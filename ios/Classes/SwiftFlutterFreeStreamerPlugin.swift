import Flutter
import UIKit
import FreeStreamer

public class SwiftFlutterFreeStreamerPlugin: NSObject, FlutterPlugin {
    let audioPlayer = FSAudioStream()
    var registrar: FlutterPluginRegistrar
    var channel: FlutterMethodChannel
    var state = -1
  
    init(pluginRegistrar: FlutterPluginRegistrar, pluginChannel: FlutterMethodChannel) {
        registrar = pluginRegistrar;
        channel = pluginChannel;
    }
    
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_free_streamer", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterFreeStreamerPlugin(pluginRegistrar: registrar, pluginChannel: channel)
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
//    audioPlayer.onFailure = ((FSAudioStream, String){
    
//    });
    audioPlayer.onFailure = self._errorStateChangeHandler();
//    audioPlayer.onStateChange =
    
    switch call.method {
        case "init":
            let args = (call.arguments as! NSDictionary)
            let urlString = args.object(forKey: "url") as! String
            let isLocal = args.object(forKey: "isLocal") as! Bool
            if(isLocal){
                let asset = self.registrar.lookupKey(forAsset: urlString);
                let path = Bundle.main.path(forAuxiliaryExecutable: asset);
                let url = NSURL(fileURLWithPath: path!)
                audioPlayer.url = url
                audioPlayer.preload()
            }else{
                let url = NSURL(string: urlString)
                audioPlayer.url = url
                audioPlayer.preload()
            }
            audioPlayer.onStateChange = self._streamStateChangeHandler()
            return result(urlString)
        case "play":
            audioPlayer.play()
            return result(true)
        case "pause":
            if(audioPlayer.isPlaying()){
                audioPlayer.pause()
            }
            return result(true)
        case "resume":
            if(!audioPlayer.isPlaying()){
                audioPlayer.pause()
            }
            return result(true)
        case "seek":
            let args = (call.arguments as! NSDictionary)
            let time = args.object(forKey: "time") as! Double
            let positionAll = audioPlayer.currentTimePlayed
            let duration = positionAll.playbackTimeInSeconds / positionAll.position
            var position = FSStreamPosition()
            position.position = Float(time) / duration
            audioPlayer.seek(to: position)
            return result(true)
        case "progress":
            let position = audioPlayer.currentTimePlayed
            return result(position.playbackTimeInSeconds)
        case "duration":
            let duration = audioPlayer.duration
            return result(duration.playbackTimeInSeconds)
        case "isPlaying":
            return result(audioPlayer.isPlaying())
        case "state":
            return result(state)
        default:
            return result(false);
    }
  }
    
    
    private func _streamStateChangeHandler() -> (FSAudioStreamState) -> Void {
        return { state1 in
            self.state = state1.rawValue
            self.channel.invokeMethod("audio.onState", arguments: self.state);
        }
    }
    
    
    private func _errorStateChangeHandler() -> (FSAudioStreamError, String?) -> Void {
        return { error,string in
            self.channel.invokeMethod("audio.onError", arguments: error.rawValue)
        }
        
    }
}
