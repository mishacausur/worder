//
//  CALayer.swift
//  worder
//
//  Created by Misha Causur on 14.01.2023.
//

import QuartzCore.CoreAnimation
import class UIKit.UIColor

extension CAGradientLayer {
    
    typealias State = TodayViewModel.ReminderState
    
    static func gradientLayer(for state: State, in frame: CGRect) -> Self {
        let layer = Self()
        layer.colors = colors(for: state)
        layer.frame = frame
        return layer
    }
    
    private static func colors(for state: State) -> [CGColor] {
        let beginColor: UIColor
        let endColor: UIColor
        
        switch state {
        case .all:
            beginColor = .todayGradientAllBegin
            endColor = .todayGradientAllEnd
        case .future:
            beginColor = .todayGradientFutureBegin
            endColor = .todayGradientFutureEnd
        case .today:
            beginColor = .todayGradientTodayBegin
            endColor = .todayGradientTodayEnd
        }
        return [beginColor.cgColor, endColor.cgColor]
    }
}
