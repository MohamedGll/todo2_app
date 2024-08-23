import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo2_app/models/task_model.dart';
import 'package:todo2_app/models/user_model.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection('Tasks')
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, options) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (task, options) {
        return task.toJson();
      },
    );
  }

  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection('Users')
        .withConverter<UserModel>(
      fromFirestore: (snapshot, options) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (user, options) {
        return user.toJson();
      },
    );
  }

  static Future<void> addTask(TaskModel task) {
    var collection = getTasksCollection(); // create collection
    var docRef = collection.doc(); // create docs
    task.id = docRef.id;
    return docRef.set(task); //set attributes
  }

  static Future<void> addUser(UserModel user) {
    var collection = getUsersCollection(); // create collection
    var docRef = collection.doc(user.id); // create docs
    return docRef.set(user); //set attributes
  }

  static Stream<QuerySnapshot<TaskModel>> getTask(DateTime date) {
    var collection = getTasksCollection();
    return collection
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('date',
            isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<UserModel?> getUserData() async {
    var collection = getUsersCollection();
    DocumentSnapshot<UserModel> userDoc =
        await collection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    return userDoc.data();
  }

  static Future<void> deleteTask(String id) {
    var collection = getTasksCollection();
    return collection.doc(id).delete();
  }

  static Future<void> updateTask(TaskModel taskModel) {
    var collection = getTasksCollection();
    return collection.doc(taskModel.id).update(taskModel.toJson());
  }

  static createAccount({
    required String email,
    required String password,
    required Function onSuccess,
    required Function onError,
    required String userName,
    required String phone,
    required int age,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // credential.user?.sendEmailVerification();
      UserModel user = UserModel(
        id: credential.user!.uid,
        userName: userName,
        phone: phone,
        age: age,
        email: email,
      );
      addUser(user);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message);
    } catch (e) {
      onError(e.toString());
    }
  }

  static login({
    required String email,
    required String password,
    required Function onSuccess,
    required Function onError,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      onSuccess();
      return credential;
    } on FirebaseAuthException catch (e) {
      onError(e.message);
    }
  }
}
