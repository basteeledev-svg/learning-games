# Assets Directory

This folder contains all the visual and audio assets for the Learning Games app.

## Directory Structure

### `images/characters/`
Place character images here:
- `cat.png` - Cat character sprite
- `dog.png` - Dog character sprite
- `rabbit.png` - Rabbit character sprite
- `bear.png` - Bear character sprite
- `fox.png` - Fox character sprite
- `jetpack.png` - Jetpack sprite

**Recommended size:** 200x200px to 400x400px PNG with transparent background

### `images/backgrounds/`
Place background images here:
- `buildings.png` - City buildings background
- `rocks.png` - Rock formations background
- `mountains.png` - Mountain landscape
- `trees.png` - Forest background

**Recommended size:** 1920x1080px or larger PNG/JPG

### `images/`
General game images:
- `platform.png` - Platform sprite
- `logo.png` - App logo

### `sounds/`
Sound effects and music:
- `jump.mp3` - Jump sound effect
- `success.mp3` - Success sound
- `fail.mp3` - Failure sound
- `background_music.mp3` - Background music

## Using Assets in Code

After adding images, you can use them like this:

```dart
Image.asset('assets/images/characters/cat.png')
```

## Notes

- After adding new assets, run `flutter pub get` to update
- Use PNG format with transparency for characters and sprites
- Keep file sizes reasonable for mobile devices (< 500KB per image)
- Use descriptive filenames
