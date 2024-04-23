#include <dlfcn.h>
#include <Foundation/Foundation.h>

void init_loadGeode(void) {
	NSLog(@"mrow init_loadGeode");

	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
	NSString *applicationSupportDirectory = [paths firstObject];

	NSString *geode_dir = [applicationSupportDirectory stringByAppendingString:@"/GeometryDash/game/geode"];
	NSString *geode_lib = [geode_dir stringByAppendingString:@"/Geode.ios.dylib"];

	NSLog(@"mrow PATH %@", applicationSupportDirectory);
	NSLog(@"mrow geode dir: %@", geode_dir);
	NSLog(@"mrow Geode lib path: %@", geode_lib);

	bool geode_exists = [[NSFileManager defaultManager] fileExistsAtPath:geode_lib];

	if (!geode_exists) {
		NSLog(@"mrow geode dylib DOES NOT EXIST! downloading...");
		// todo
		return;
	}
	NSLog(@"mrow trying to load Geode library from %@", geode_lib);

	//dlopen("/usr/lib/Geode.dylib", RTLD_LAZY);
	dlopen([geode_lib UTF8String], RTLD_LAZY);
}
