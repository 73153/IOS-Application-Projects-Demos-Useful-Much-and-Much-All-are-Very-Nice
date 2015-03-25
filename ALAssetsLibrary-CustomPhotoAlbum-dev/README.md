ALAssetsLibrary-CustomPhotoAlbum
================================

A nice ALAssetsLibrary category for saving images into custom photo album by @MarinTodorov.

# Usage

    //      |image|: The target image to be saved
    //  |albumName|: Custom album name
    // |completion|: Block to be executed when succeed to write the image data
    //               to the assets library (camera roll)
    //    |failure|: Block to be executed when failed to add the asset to the
    //               custom photo album
    - (void)saveImage:(UIImage *)image
              toAlbum:(NSString *)albumName
           completion:(ALAssetsLibraryWriteImageCompletionBlock)completion
              failure:(ALAssetsLibraryAccessFailureBlock)failure;

And for video:

    //   |videoUrl|: The target video to be saved
    //  |albumName|: Custom album name
    // |completion|: Block to be executed when succeed to write the image data
    //               to the assets library (camera roll)
    //    |failure|: Block to be executed when failed to add the asset to the
    //               custom photo album
    - (void)saveVideo:(NSURL *)videoUrl
              toAlbum:(NSString *)albumName
           completion:(ALAssetsLibraryWriteImageCompletionBlock)completion
              failure:(ALAssetsLibraryAccessFailureBlock)failure;

Write the image data with meta data to the assets library (camera roll).
    
    //  |imageData|: The image data to be saved
    //  |albumName|: Custom album name
    //   |metadata|: Meta data for image
    // |completion|: Block to be executed when succeed to write the image data
    //    |failure|: block to be executed when failed to add the asset to the custom photo album
    - (void)saveImageData:(NSData *)imageData
                  toAlbum:(NSString *)albumName
                 metadata:(NSDictionary *)metadata
               completion:(ALAssetsLibraryWriteImageCompletionBlock)completion
                  failure:(ALAssetsLibraryAccessFailureBlock)failure;

# Dependence

  1. AssetsLibrary.framework
  2. MobileCoreServices.framework


# REFERENCE

- [ALAssetsLibrary Class Reference][1]  
- [iOS5: Saving photos in custom photo album][2]


# Contributors

[@MarinTodorov](http://www.touch-code-magazine.com/about/)  
[@Kjuly](https://github.com/Kjuly)  
[@coryjthompson](https://github.com/coryjthompson)  
[@speedyapocalypse](https://github.com/speedyapocalypse)  
[@blazingpair](https://github.com/blazingpair) ([@paulz](https://github.com/paulz))  

[1]: http://developer.apple.com/library/ios/#documentation/AssetsLibrary/Reference/ALAssetsLibrary_Class/Reference/Reference.html#//apple_ref/occ/instm/ALAssetsLibrary/addAssetsGroupAlbumWithName:resultBlock:failureBlock:
[2]: http://www.touch-code-magazine.com/ios5-saving-photos-in-custom-photo-album-category-for-download/
