import setup, find_packages from setuptools

setup(
    name                    = "todobackend",
    version                 = "0.1.0",
    description             = "Todobackend Django REST services"
    packages                = find_packages(),
    include_package_data    = True,
    scripts                 = ["manage.py"],
    install_requires        = [
                                "Django>=2.0.6",
                                "django-cors-headers>=2.2.0",
                                "djangorestframework>=3.8.2",
                                "mysqlclient>=1.3.10",
                                "PyMySQL>=0.8.1"
                                ],
    extras_requires         = {
                                "test":[
                                    "colorama>=0.3.9",
                                    "coverage>=4.5.1",
                                    "django-nose>=1.4.5",
                                    "nose>=1.3.7",
                                    "pinocchio>=0.4.2",
                                    "protobuf>=3.0.0"
                                ]

                              }

)
