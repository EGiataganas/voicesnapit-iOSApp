//
//  ImageDescriptionSyntetizer.swift
//  VoiceSnapIT
//
//  Created by Evangelos Giataganas on 29/10/2017.
//  Copyright © 2017 Evangelos Giataganas. All rights reserved.
//

import AVFoundation

struct StringSynthesizer {
    var synthesizer: AVSpeechSynthesizer
    
    init(synthesizer: AVSpeechSynthesizer = AVSpeechSynthesizer()) {
        self.synthesizer = synthesizer
    }
    
    func synthesizeString(string: String) {
        let myUtterance = AVSpeechUtterance(string: string)
        myUtterance.rate = 0.4
        synthesizer.speak(myUtterance)
    }
}
