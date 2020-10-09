import 'dart:async';

import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as path;

ArgResults argResults;
const projectName = "project-name";
const firebase = "firebase";
const orgName = "org";
const androidLang = "android-language";
const iosLang = "ios-language";
final scriptPath = path.dirname(Platform.script.path);
final currentDirectoryPath = Directory.current.path;

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption(projectName, abbr: "p")
    ..addOption(orgName, abbr: "o")
    ..addOption(androidLang, abbr: "a")
    ..addOption(iosLang, abbr: "i")
    ..addFlag(firebase, negatable: false, abbr: "f");

  argResults = parser.parse(arguments);
  final folder = argResults.rest;

  final flutterArgs = getFlutterArgs(folder[0]);
  await createFlutterProject(flutterArgs);
  await generateArchitecture(folder[0]);
  await Process.run("flutter", ["pub", "get"],
      workingDirectory: currentDirectoryPath + "/${folder[0]}");
  stdout.write("Project ready!");
}

Future<void> generateArchitecture(String folder) async {
  var libPath = currentDirectoryPath + "/$folder/lib";
  var pubspecPath = currentDirectoryPath + "/$folder/pubspec.yaml";
  //replacing lib folder
  await Directory(libPath).delete(recursive: true);
  await Directory(libPath).create();
  copyDirectory(Directory(scriptPath + "/templates/lib"), Directory(libPath));
  //replacing pubspec file
  await File(pubspecPath).delete();
  var pubspec =
      await File(scriptPath + '/templates/pubspec.yaml').copy(pubspecPath);
  var content = await pubspec.readAsString();
  var newContent = content.replaceFirst("test_project",
      argResults[projectName] != null ? argResults[projectName] : folder);
  await pubspec.writeAsString(newContent);
}

List<String> getFlutterArgs(String folder) {
  final List<String> args = [];
  var _projectName = argResults[projectName];
  var _orgName = argResults[orgName];
  var _androidLang = argResults[androidLang];
  var _iosLang = argResults[iosLang];
  if (_projectName != null) {
    args.add("--project-name");
    args.add(_projectName);
  }
  if (_orgName != null) {
    args.add("--org");
    args.add(_orgName);
  }
  if (_androidLang != null &&
      (_androidLang == "java" || _androidLang == "kotlin")) {
    args.add("-a");
    args.add(_androidLang);
  }
  if (_iosLang != null && (_iosLang == "swift" || _iosLang == "objc")) {
    args.add("-i");
    args.add(_iosLang);
  }
  args.add(folder);
  return args;
}

Future<void> createFlutterProject(List<String> args) async {
  var result =
      await Process.run("flutter", ["create", ...args], runInShell: true);
  stderr.write(result.stderr);
}

void copyDirectory(Directory source, Directory destination) =>
    source.listSync(recursive: false).forEach((var entity) {
      if (entity is Directory) {
        var newDirectory = Directory(
            path.join(destination.absolute.path, path.basename(entity.path)));
        newDirectory.createSync();

        copyDirectory(entity.absolute, newDirectory);
      } else if (entity is File) {
        entity
            .copySync(path.join(destination.path, path.basename(entity.path)));
      }
    });
