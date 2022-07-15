@testable import MyNewCar

enum MakeObjects {
    static var mock: [Make] {
        return [
            .init(id: "10",
                  name: "Maserati",
                  imageUrl: "https://www.carlogos.org/car-logos/maserati-logo-2020.png"),
            .init(id: "11",
                  name: "Audi",
                  imageUrl: "https://www.carlogos.org/car-logos/audi-logo-2016.png"),
            .init(id: "12",
                  name: "Jeep",
                  imageUrl: "https://www.carlogos.org/car-logos/jeep-logo-1993.png"),
            .init(id: "13",
                  name: "Subaru",
                  imageUrl: "https://www.carlogos.org/car-logos/subaru-logo-2003.png"),
            .init(id: "14",
                  name: "Cadillac",
                  imageUrl: "https://www.carlogos.org/car-logos/cadillac-logo-2021.png"),
            .init(id: "15",
                  name: "Chrysler",
                  imageUrl: "https://www.carlogos.org/car-logos/chrysler-logo-2010.png"),
            .init(id: "16",
                  name: "Chevrolet",
                  imageUrl: "https://www.carlogos.org/logo/Corvette-logo-2014-1024x768.png"),
            .init(id: "17",
                  name: "Dodge",
                  imageUrl: "https://www.carlogos.org/logo/Dodge-logo-2011-3840x2160.png"),
            .init(id: "18",
                  name: "Hyundai",
                  imageUrl: "https://www.carlogos.org/logo/Hyundai-logo-silver-2560x1440.png"),
            .init(id: "19",
                  name: "Jaguar",
                  imageUrl: "https://www.carlogos.org/logo/Jaguar-logo-2012-1920x1080.png"),
            .init(id: "20",
                  name: "Mazda",
                  imageUrl: "https://www.carlogos.org/logo/Mazda-logo-1997-1920x1080.png")
        ]
    }
}
