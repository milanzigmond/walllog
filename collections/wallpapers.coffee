Wallpapers = new Mongo.Collection("wallpapers")

# Wallpapers.before.insert(function( userId, doc ) {
# 	doc.createdAt = new Date();
# 	doc.userId = userId;
# });