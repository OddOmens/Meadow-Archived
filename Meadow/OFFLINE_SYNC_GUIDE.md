# Meadow - Offline & iCloud Sync Guide

## Overview
Meadow is designed to work seamlessly both **offline** and **online**, with optional iCloud sync. The app **does not require** iCloud to function.

## How It Works

### Local-First Architecture
- **Primary Storage**: All data is stored locally on your device in a SQLite database
- **Location**: `Documents/Meadow.sqlite`
- **Always Available**: The app works 100% offline without any internet connection

### Optional iCloud Sync
- **Automatic Detection**: The app automatically detects if iCloud is available
- **Seamless Sync**: When iCloud is available, data syncs automatically across devices
- **No Configuration Needed**: Users don't need to do anything - it just works

### Sync Status Indicators
Users can see their sync status in the Profile tab:
- **"Synced with iCloud"** - iCloud is available and data is syncing
- **"Syncing with iCloud..."** - Active sync in progress
- **"Local Storage Only"** - iCloud not available, data stored locally only

## Technical Implementation

### Persistence Layer
The `PersistenceController` handles three scenarios:

1. **iCloud Available**
   - Uses `NSPersistentCloudKitContainer` with CloudKit enabled
   - Data syncs automatically to iCloud
   - Local store remains primary

2. **iCloud Unavailable**
   - Disables CloudKit sync
   - Uses local SQLite store only
   - No data loss - everything works normally

3. **Error Recovery**
   - If CloudKit fails, automatically falls back to local-only mode
   - If store is corrupted, creates fresh local store
   - Never crashes due to sync issues

### Conflict Resolution
- **Merge Policy**: `NSMergeByPropertyObjectTrumpMergePolicy`
- **Strategy**: Most recent changes win
- **Automatic**: No user intervention needed

## User Experience

### What Users See
- ✅ App works immediately without setup
- ✅ No "Sign in to iCloud" prompts
- ✅ No sync errors blocking usage
- ✅ Clear status indicator in Profile
- ✅ Seamless experience whether online or offline

### Data Safety
- ✅ All data saved locally first
- ✅ No data loss if iCloud unavailable
- ✅ Automatic recovery from errors
- ✅ No fatalError crashes

## Testing Scenarios

### Test 1: Offline Mode
1. Turn off WiFi and cellular
2. Open app
3. Create/edit data
4. ✅ Everything works normally
5. Status shows "Local Storage Only"

### Test 2: iCloud Sync
1. Ensure iCloud is enabled
2. Open app
3. Status shows "Synced with iCloud"
4. Create data on Device A
5. ✅ Data appears on Device B

### Test 3: iCloud Disabled
1. Sign out of iCloud
2. Open app
3. ✅ App continues working
4. Status shows "Local Storage Only"
5. Data remains accessible

### Test 4: Network Issues
1. Start with iCloud enabled
2. Lose internet connection
3. ✅ App continues working
4. Changes saved locally
5. Sync resumes when connection restored

## Developer Notes

### Key Files
- `Persistence.swift` - Core data stack with offline/online handling
- `SyncStatusManager.swift` - Monitors sync status and iCloud availability
- `MeadowApp.swift` - Injects sync status manager

### Error Handling
All CoreData operations include:
- Try-catch blocks
- Cleanup on failure
- Fallback to local storage
- User-friendly error messages

### Best Practices Implemented
✅ Local-first architecture
✅ Graceful degradation
✅ Automatic error recovery
✅ No blocking operations
✅ Clear user feedback
✅ No data loss scenarios

## Future Enhancements
- [ ] Manual sync trigger button
- [ ] Sync conflict resolution UI
- [ ] Data export/import
- [ ] Sync history log
- [ ] Bandwidth usage optimization
