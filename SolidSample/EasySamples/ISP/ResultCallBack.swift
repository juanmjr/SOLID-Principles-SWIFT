//
//  ResultCallBack.swift
//  SolidSample
//
//  Created by Juan Munhoes Junior on 22/06/22.
//

/**
 Big funcionalities by categories - i don't want to implement everyone.
 Just need a single protocol for that.
 */

protocol IResultSuccess {
    func successBlock()
}

protocol IResultErrorPersonNotFound {
    func personNotFoundBlock()
}

protocol IResultErrorEmailNotFound {
    func emailNotFoundBlock()
}

protocol IResultErrorDefault {
    func defaultErrorBlock()
}

struct IJustWantSuccess: IResultSuccess {
    func successBlock() {
        print("Hey, I've got what you want :)")
    }
}

struct IJustWantDefaultError: IResultErrorDefault {
    func defaultErrorBlock() {
        print("I'm a default error :)")
    }
}

struct IJustWantErrors: IResultErrorPersonNotFound, IResultErrorEmailNotFound {
    func personNotFoundBlock() {
        print("The person was not found :(")
    }
    
    func emailNotFoundBlock() {
        print("Person`s e-mail was not found :(")
    }
}
