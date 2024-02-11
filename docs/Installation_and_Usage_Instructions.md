## Instructions for Installation

* Use Installation Guide provided in docs


1. Install the required software environments
2. Use these guides if you are new to Ruby on Rails: 
    - https://human-se.github.io/rails-demos-n-deets-2021/
    - https://guides.rubyonrails.org/index.html
    - https://www.youtube.com/watch?v=fmyvWz5TUWg
3. Create SSH key and add it to Github profile 
4. Create a repository on your Github account
5. Fork or clone the project to your own remote repository

## Instructions for Running 
1. Go into the src folder of the project in your Linux environment
    => cd src/
2. Find your IP address
    => ip addr show eth0
3. Start rails server
    => rails --binding=YOUR.IP.ADDRESS.HERE 
    OR
    => rails s
4. Open server link in browser 
5. Contribute to development in VSCode
    - Saving automatically updates application
* Current link established at: http://csc415-team11.hpc.tcnj.edu:3000/