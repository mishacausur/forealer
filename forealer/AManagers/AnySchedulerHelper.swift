//
//  AnySchedulerHelper.swift
//  forealer
//
//  Created by Misha Causur on 12.04.2022.
//

import Combine

public struct AnyScheduler<SchedulerTimeType, SchedulerOptions>: Scheduler where SchedulerTimeType: Strideable, SchedulerTimeType.Stride: SchedulerTimeIntervalConvertible {
    public var now: SchedulerTimeType
    
    public func schedule(options: SchedulerOptions?, _ action: @escaping () -> Void) { }
    
    public func schedule(after date: SchedulerTimeType, interval: SchedulerTimeType.Stride, tolerance: SchedulerTimeType.Stride, options: SchedulerOptions?, _ action: @escaping () -> Void) -> Cancellable { }
    
    public func schedule(after date: SchedulerTimeType, tolerance: SchedulerTimeType.Stride, options: SchedulerOptions?, _ action: @escaping () -> Void) { }
    
    public var minimumTolerance: SchedulerTimeType.Stride
}
