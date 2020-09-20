import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StreamProvider.value(
    initialData: CurrentUser.initial,
    value: FirebaseAuth.instance.onAuthStateChanged.map((user) => CurrentUser.create(user)),
    child: Consumer<CurrentUser>(
      builder: (context, user, _) => MaterialApp(
        title: 'Flutter Keep',
        home: user.isInitialValue
            ? Scaffold(body: const Text('Loading...'))
            : user.data != null ? HomeScreen() : LoginScreen(),
      ),
    ),
  );
}

class CurrentUser {
  final bool isInitialValue;
  final FirebaseUser data;

  const CurrentUser._(this.data, this.isInitialValue);
  factory CurrentUser.create(FirebaseUser data) => CurrentUser._(data, false);

  /// The inital empty instance.
  static const initial = CurrentUser._(null, true);
}

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  String _errorMessage;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: _signInWithGoogle,
            child: const Text('Continue with Google'),
          ),
          if (_errorMessage != null) Text(
            _errorMessage,
            style: const TextStyle(color: Colors.red),
          ),
        ],
      ),
    ),
  );

  void _signInWithGoogle() async {
    _setLoggingIn(); // show progress
    String errMsg;

    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      await _auth.signInWithCredential(credential);
    } catch (e) {
      errMsg = 'Login failed, please try again later.';
    } finally {
      _setLoggingIn(false, errMsg); // always stop the progress indicator
    }
  }
  /// update the logging-in indicator, & show error message if any
  void _setLoggingIn([bool loggingIn = true, String errMsg]) {
    if (mounted) {
      setState(() {
        _loggingIn = loggingIn;
        _errorMessage = errMsg;
      });
    }
  }
}

class Note {
  final String id;
  String title;
  String content;
  Color color;
  NoteState state;
  final DateTime createdAt;
  DateTime modifiedAt;

  /// Instantiates a [Note].
  Note({
    this.id,
    this.title,
    this.content,
    this.color,
    this.state,
    DateTime createdAt,
    DateTime modifiedAt,
  }) : this.createdAt = createdAt ?? DateTime.now(),
        this.modifiedAt = modifiedAt ?? DateTime.now();

  /// Transforms the Firestore query [snapshot] into a list of [Note] instances.
  static List<Note> fromQuery(QuerySnapshot snapshot) => snapshot != null ? toNotes(snapshot) : [];
}

/// State enum for a note.
enum NoteState {
  unspecified,
  pinned,
  archived,
  deleted,
}

/// Transforms the query result into a list of notes.
List<Note> toNotes(QuerySnapshot query) => query.documents
    .map((d) => toNote(d))
    .where((n) => n != null)
    .toList();

/// Transforms a document into a single note.
Note toNote(DocumentSnapshot doc) => doc.exists
    ? Note(
  id: doc.documentID,
  title: doc.data['title'],
  content: doc.data['content'],
  state: NoteState.values[doc.data['state'] ?? 0],
  color: _parseColor(doc.data['color']),
  createdAt: DateTime.fromMillisecondsSinceEpoch(doc.data['createdAt'] ?? 0),
  modifiedAt: DateTime.fromMillisecondsSinceEpoch(doc.data['modifiedAt'] ?? 0),
)
    : null;

Color _parseColor(num colorInt) => Color(colorInt ?? 0xFFFFFFFF);

/// Home screen, displays [Note] in a Grid or List.
class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _gridView = true; // `true` to show a Grid, otherwise a List.

  @override
  Widget build(BuildContext context) => StreamProvider.value(
    value: _createNoteStream(context),
    child: Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _appBar(context), // a floating appbar
          const SliverToBoxAdapter(
            child: SizedBox(height: 24), // top spacing
          ),
          _buildNotesView(context),
          const SliverToBoxAdapter(
            child: SizedBox(height: 80.0), // bottom spacing make sure the content can scroll above the bottom bar
          ),
        ],
      ),
      floatingActionButton: _fab(context),
      bottomNavigationBar: _bottomActions(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      extendBody: true,
    ),
  );

  /// A floating appBar like the one of Google Keep
  Widget _appBar(BuildContext context) => SliverAppBar(
    floating: true,
    snap: true,
    title: _topActions(context),
    automaticallyImplyLeading: false,
    centerTitle: true,
    titleSpacing: 0,
    backgroundColor: Colors.transparent,
    elevation: 0,
  );

  Widget _topActions(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: <Widget>[
            const SizedBox(width: 20),
            const Icon(Icons.menu),
            const Expanded(
              child: Text('Search your notes', softWrap: false),
            ),
            InkWell(
              child: Icon(_gridView ? Icons.view_list : Icons.view_module),
              onTap: () => setState(() {
                _gridView = !_gridView; // switch between list and grid style
              }),
            ),
            const SizedBox(width: 18),
            _buildAvatar(context),
            const SizedBox(width: 10),
          ],
        ),
      ),
    ),
  );

  Widget _bottomActions() => BottomAppBar(
    shape: const CircularNotchedRectangle(),
    child: Container(
      height: kBottomBarSize,
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Row(
      ...
      ),
    ),
  );

  Widget _fab(BuildContext context) => FloatingActionButton(
    child: const Icon(Icons.add),
    onPressed: () {},
  );

  Widget _buildAvatar(BuildContext context) {
    final url = Provider.of<CurrentUser>(context)?.data?.photoUrl;
    return CircleAvatar(
      backgroundImage: url != null ? NetworkImage(url) : null,
      child: url == null ? const Icon(Icons.face) : null,
      radius: 17,
    );
  }

  /// A grid/list view to display notes
  Widget _buildNotesView(BuildContext context) => Consumer<List<Note>>(
    builder: (context, notes, _) {
      if (notes?.isNotEmpty != true) {
        return _buildBlankView();
      }

      final widget = _gridView ? NotesGrid.create : NotesList.create;
      return widget(notes: notes, onTap: (_) {});
    },
  );

  Widget _buildBlankView() => const SliverFillRemaining(
    hasScrollBody: false,
    child: Text('Notes you add appear here',
      style: TextStyle(
        color: Colors.black54,
        fontSize: 14,
      ),
    ),
  );

  /// Create the notes query
  Stream<List<Note>> _createNoteStream(BuildContext context) {
    final uid = Provider.of<CurrentUser>(context)?.data?.uid;
    return Firestore.instance.collection('notes-$uid')
        .where('state', isEqualTo: 0)
        .snapshots()
        .handleError((e) => debugPrint('query notes failed: $e'))
        .map((snapshot) => Note.fromQuery(snapshot));
  }
}

class NotesGrid extends StatelessWidget {
  final List<Note> notes;
  final void Function(Note) onTap;

  const NotesGrid({Key key, this.notes, this.onTap}) : super(key: key);

  /// A static factory method can be used as a function reference
  static NotesGrid create({Key key, this.notes, this.onTap}) =>
      NotesGrid(key: key, notes: notes, onTap: onTap);

  @override
  Widget build(BuildContext context) => SliverGrid(
  ...
  );
}

// The editor of a [Note], also shows every detail about a single note.
class NoteEditor extends StatefulWidget {
  /// Create a [NoteEditor],
  /// provides an existed [note] in edit mode, or `null` to create a new one.
  const NoteEditor({Key key, this.note}) : super(key: key);

  final Note note;

  @override
  State<StatefulWidget> createState() => _NoteEditorState(note);
}

class _NoteEditorState extends State<NoteEditor> {
  _NoteEditorState(Note note)
      : this._note = note ?? Note(),
        _originNote = note?.copy() ?? Note(),
        this._titleTextController = TextEditingController(text: note?.title),
        this._contentTextController = TextEditingController(text: note?.content);
  ...

  /// Returns `true` if the note is modified.
  bool get _isDirty => _note != _originNote;
  ...
}

/// Presses the FAB to create a new note
Widget _fab(BuildContext context) => FloatingActionButton(
...
onPressed: () => Navigator.pushNamed(context, '/note'),
);

/// Starts editing a note when tapped
void _onNoteTap(Note note) =>
    Navigator.pushNamed(context, '/note', arguments: { 'note': note });

@override
Widget build(BuildContext context) {
  final uid = Provider.of<CurrentUser>(context).data.uid;
  return ChangeNotifierProvider.value(
    value: _note,
    child: Consumer<Note>(
      builder: (_, __, ___) => Theme(
        data: Theme.of(context).copyWith(
            primaryColor: _noteColor,
            ...
        ),
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          // tint the Android system navigation bar
          value: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: _noteColor,
            systemNavigationBarColor: _noteColor,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              actions: _buildTopActions(context, uid),
            ),
            body: WillPopScope(
              onWillPop: () => _onPop(uid),
              child: _buildBody(context, uid), // textfields for title/content
            ),
            bottomNavigationBar: _buildBottomAppBar(context),
          ),
        ),
      ),
    ),
  );
}

/// Callback before the user dismiss the editor
Future<dynamic> _onPop(String uid) => _isDirty
    ? saveToFireStore(uid, _note)
    : Future.value();

class Note extends ChangeNotifier {
  ...
  /// Update specified properties and notify the listeners
  void updateWith({
  String title,
  String content,
  Color color,
  NoteState state,
  }) {
  ...
  notifyListeners();
  }
}