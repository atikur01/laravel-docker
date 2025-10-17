🎓 Student & Course API Documentation

This API provides endpoints for managing Students and Courses, including creating, updating, deleting, and assigning courses to students.
Built with Laravel and Eloquent Relationships.

------------------------------------------------------------
Base URL:
    /api

------------------------------------------------------------
STUDENT ENDPOINTS

1. GET /students
   Description: Returns a list of all students with their assigned courses.

2. POST /students
   Description: Create a new student.
   Body Parameters:
     - name (string, required)

3. GET /students/{id}
   Description: Fetch a student by ID with their assigned courses.

4. PUT/PATCH /students/{id}
   Description: Update a student's details.
   Body Parameters:
     - name (string, optional)

5. DELETE /students/{id}
   Description: Delete a student.
   Response: { "message": "Student deleted" }

6. POST /students/{id}/assign-courses
   Description: Assign or sync multiple courses to a student.
   Body Parameters:
     - course_ids (array, required)

------------------------------------------------------------
COURSE ENDPOINTS

1. GET /courses
   Description: Retrieve all courses with enrolled students.

2. POST /courses
   Description: Create a new course.
   Body Parameters:
     - title (string, required)

3. GET /courses/{id}
   Description: Fetch a course by ID with enrolled students.

4. PUT/PATCH /courses/{id}
   Description: Update course details.
   Body Parameters:
     - title (string, optional)

5. DELETE /courses/{id}
   Description: Delete a course.
   Response: { "message": "Course deleted" }

------------------------------------------------------------
RELATIONSHIPS

Student ↔ Course: Many-to-Many
A student can have many courses.
A course can have many students.

Ensure the pivot table 'course_student' exists with columns:
    student_id | course_id



docker-compose build

docker-compose up -d

docker-compose exec app composer install

docker-compose exec app php artisan key:generate

docker-compose exec app php artisan migrate

docker-compose stop

docker-compose start
