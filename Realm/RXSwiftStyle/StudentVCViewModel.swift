//
//  StudentVCViewModel.swift
//  MyPlayground
//
//  Created by JohnConnor on 2020/5/24.
//  Copyright © 2020 JohnConnor. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift
import RxRelay
class StudentVCViewModel: NSObject {
    lazy var studentsPublishSubject : BehaviorRelay<Results<RXStudentModel>?> = {
        let result = BehaviorRelay<Results<RXStudentModel>?>( value: nil) // useed be add student
        return result
    }()
    override init() {
        super.init()
        self.getDataFromNetworkOrDatabase()
    }
    
    
    
    
    
    
    
    
    private func getDataFromNetworkOrDatabase() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {//get data from network or database with delay
            let resultsOfStudents = RXStudentModel.getStudents()// get data from db
            self.studentsPublishSubject.accept(resultsOfStudents)
        }
    }
    
    
    /*
    func getStudentsObservable() -> Observable<Results<RXStudentModel>> {
        return Observable<Results<RXStudentModel>>.create { (observerAble) -> Disposable in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {//get data from network or database with delay
                let resultsOfStudents = RXStudentModel.getStudents()
                observerAble.onNext(resultsOfStudents)
            }
            return Disposables.create()
        }
    }
    
    func getStudentObservable() -> Observable< RXStudentModel > {
        return Observable< RXStudentModel >.create { (observerAble) -> Disposable in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {//get data from network or database with delay
                let student = RXStudentModel()
                student.name = String("qwertyuiopasdfghjklzxcvbnm".randomElement() ?? "x") + String("qwertyuiopoiuytasdfghjklkjhgzxcvbnm,mnbvc".randomElement() ?? "x")
                observerAble.onNext(student)
            }
            return Disposables.create()
        }
    }
 */
}
