import Foundation

final class ScreenLogger {

    static func log(_ screen: ScreenModel) {
        print(
        """


        ===========================================
        SCREEN MODEL
        ===========================================

        """
        )

        print(screen.screenName)
        print("|")
        screen.templates.forEach { template in
            print("| \t " + template.id)
            print("| \t " + template.type.rawValue)
            print("| \t |")

            template.components.forEach { component in
                print("| \t | \t " + component.id)
                print("| \t | \t " + component.type.rawValue)
                print("| \t | \t |")
                print("| \t | \t | \t " + component.body.id)
                print("| \t | \t | \t | ")

                let data = component.body.data
                for (key, value) in data {
                    print("| \t | \t | \t | \t " + key + " : " + value)
                }
                print("| \t | \t | \t | ")
            }
        }

        print(
        """

        ===========================================


        """
        )
    }
}
