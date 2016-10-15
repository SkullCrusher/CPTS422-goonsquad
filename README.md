# CPTS422-goonsquad - Receipt management system
RMS is a small website that allows users to upload receipts, manage, and search.

# Installation.
1. Install Eclipse for JavaEE developers, and create a new project.
2. Install Tomee and set it up Eclipse in eclipse.
3. Add the Java to the Java folder and the jsp in the web folder.
4. Add the libraries to the build path.
5. Install MYSQL.
6. Use the install script to set up the database.
7. Create a MYSQL user, give it access to the database, and switch out the one in the MYSQL hacks.
8. Run.

# Assignment writeup

#### RMS: an online receipt management system

###### General Requirements:
The purpose of this assignment is to get you familiar with Java EE and other web technologies including HTML, CSS, and Javascript.

###### You will create a web application in Java EE. The application will enable a user to manage scanned store receipts (in PDF)  online with the following functions:
1. Upload scanned receipts;
2. Attach with each receipt the information including total charge, store name, receipt time.
3. Manually enter the information with a receipt;
4. Automatically extract the information using ABBYY, a cloud-based OCR SDK;
5. User writes the specification for text fields in xml, or;
6. User can draw regions for text fields, and RMS will automatically generate XML specification (Bonus);
7. User can organize the receipts by time and by store.
8. User can view the receipt online and download it.

###### Testing:
1. You and your team are responsible for testing your application. Below are some sample receipts. Note: the receipts the instructor will use to validate your application are beyond these samples.

###### Deliverables: Your team will submit 3 artifacts:
1. Axure file for UI design;
2. UML Activity diagram specifying the user's workflow of using the website. The Activity diagram is developed in Rational RSA;
3. The RSM web app, including the deployment instruction to Java EE glassfish server.
