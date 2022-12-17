# SepiaProject

## Getting Started

### Project Details

There are two screens. The first screen is a list of pets. Each pet item includes pet images
and names.
Data for showing the list is available in the pets_list.json


Tapping on a pets list item brings up the second screen. This screen is a details screen
showing the information related to the given pet which is provided in the pets_list.json as
content_url.

The application content should only be visible during working hours.
Working hours details are available in config.json.
In case of non-working hours, the application should block the user from accessing the
application content and show the popup message to the user.

### Project Structure

To keep all those hundreds of source files from ending up in the same directory, it's a good idea to set up some folder structure depending on your architecture. For instance, you can use the following:

    ├─ Models
    ├─ Views
    ├─ ViewModels
    ├─ Resources 
    ├─ Helper
    ├─ Network Module
    
### Architecture

* [Model-View-ViewModel (MVVM)][mvvm]
    * Motivated by "massive view controllers": MVVM considers `UIViewController` subclasses part of the View and keeps them slim by maintaining all state in the ViewModel.
    
    
### Models
 
    ├─ PetModel(For pet data)
    ├─ WorkingTimeConfigModel(For config data)
    
### Views
 
    ├─ ConfigView(Where we restrict user with respect to config)
    ├─ PetView(Show the list of pets)
    ├─ PetDetailsView(Show the details of pets)
    
## Assets

    ├─ AppIcon(Its bydefult one)
    ├─ not-working(Used for show user when there is some restriction)
    ├─ working(Used for show user when there is no restriction)
    
