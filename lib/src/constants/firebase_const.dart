import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

//* VARIABLES
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
FirebaseStorage firebaseStorage = FirebaseStorage.instance;
User? currentUser = FirebaseAuth.instance.currentUser;

//* COLLECTIONS
const collectionUser = "users";
const collectionDestination = "destinations";
const collectionFriends = "friends";
const collectionNews = "news";