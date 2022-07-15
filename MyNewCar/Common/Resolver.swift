import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        registerInteractor()
        registerUI()
    }
}

// MARK: - Core registrations
extension Resolver {
    static func registerInteractor() {
        register { resolver in
            MakeInteractor()
        }.implements(MakeInteractorInterface.self)
        .scope(.application)

        register { resolver in
            UserInteractor()
        }.implements(UserInteractorInterface.self)
        .scope(.application)
    }
}

// MARK: - UI registrations
extension Resolver {
    static func registerUI() {
        register { resolver in
            MainViewModel(userInteractor: resolver.resolve(UserInteractorInterface.self))
        }.implements(MainViewModelInterface.self)

        register { resolver in
            MakeListViewModel(makeInteractor: resolver.resolve(MakeInteractorInterface.self),
                              userInteractor: resolver.resolve(UserInteractorInterface.self))
        }.implements(MakeListViewModelInterface.self)
    }
}
