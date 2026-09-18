import 'app_database.dart';
class UserDataRepository{
 UserDataRepository(this.db);final AppDatabase db;
 Future<void> setBookmark({required String contentType,required String contentId})async{final id='$contentType:$contentId';await db.into(db.bookmarks).insertOnConflictUpdate(BookmarksCompanion.insert(id:id,contentType:contentType,contentId:contentId,createdAt:DateTime.now()));}
 Future<void> removeBookmark({required String contentType,required String contentId})async{await(db.delete(db.bookmarks)..where((t)=>t.contentType.equals(contentType)&t.contentId.equals(contentId))).go();}
 Stream<List<Bookmark>> watchBookmarks()=>db.select(db.bookmarks).watch();
 Future<void> saveNote({required String contentType,required String contentId,required String text})async{final id='$contentType:$contentId';await db.into(db.notes).insertOnConflictUpdate(NotesCompanion.insert(id:id,contentType:contentType,contentId:contentId,text:text,updatedAt:DateTime.now()));}
 Future<void> saveProgress({required String contentType,required String contentId,required int position})async{final id='$contentType:$contentId';await db.into(db.readingProgress).insertOnConflictUpdate(ReadingProgressCompanion.insert(id:id,contentType:contentType,contentId:contentId,position:position,updatedAt:DateTime.now()));}
 Future<ReadingProgressData?> getProgress({required String contentType,required String contentId})=>(db.select(db.readingProgress)..where((t)=>t.contentType.equals(contentType)&t.contentId.equals(contentId))).getSingleOrNull();
}