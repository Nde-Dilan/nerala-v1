const admin = require('firebase-admin');
const fetch = require('node-fetch');
const serviceAccount = require('./path-to-your-service-account.json');

// Initialize Firebase Admin
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  storageBucket: 'your-project-id.appspot.com'
});

const db = admin.firestore();
const bucket = admin.storage().bucket();

const stories = require('../lib/data/stories/stories.js').stories;

async function uploadImage(url, storyTitle) {
  try {
    const response = await fetch(url);
    const buffer = await response.buffer();
    
    const fileName = `stories/${storyTitle}/${url.split('/').pop()}`;
    const file = bucket.file(fileName);
    
    await file.save(buffer, {
      metadata: {
        contentType: 'image/jpeg'
    }});
    
    const [signedUrl] = await file.getSignedUrl({
      action: 'read',
      expires: '03-01-2500' // Long expiration
    });
    
    return signedUrl;
  } catch (error) {
    console.error(`Error uploading image for ${storyTitle}:`, error);
    return url; // Fallback to original URL if upload fails
  }
}

async function uploadStories() {
  const batch = db.batch();
  
  for (const story of stories) {
    try {
      // Upload images and get new URLs
      const imageUrl = await uploadImage(story.imageUrl, story.title);
      const thumbnailUrl = await uploadImage(story.thumbnailUrl, story.title);
      
      // Create story document
      const storyRef = db.collection('stories').doc();
      batch.set(storyRef, {
        ...story,
        imageUrl,
        thumbnailUrl,
        createdAt: admin.firestore.FieldValue.serverTimestamp()
      });
      
      console.log(`Processed story: ${story.title}`);
    } catch (error) {
      console.error(`Error processing story ${story.title}:`, error);
    }
  }
  
  // Commit the batch
  try {
    await batch.commit();
    console.log('All stories uploaded successfully!');
  } catch (error) {
    console.error('Error committing batch:', error);
  }
}

uploadStories().then(() => {
  console.log('Upload complete');
  process.exit(0);
}).catch(error => {
  console.error('Upload failed:', error);
  process.exit(1);
});