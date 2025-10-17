<?php

namespace App\Http\Controllers;

use App\Models\Student;
use Illuminate\Http\Request;

class StudentController extends Controller
{
    public function index()
    {
        return Student::with('courses')->get();
    }

    public function store(Request $request)
    {
        $request->validate(['name' => 'required']);
        return Student::create($request->all());
    }

    public function show($id)
    {
        return Student::with('courses')->findOrFail($id);
    }

    public function update(Request $request, $id)
    {
        $student = Student::findOrFail($id);
        $student->update($request->all());
        return $student;
    }

    public function destroy($id)
    {
        Student::destroy($id);
        return response()->json(['message' => 'Student deleted']);
    }

    public function assignCourses(Request $request, $id)
    {
        $student = Student::findOrFail($id);
        $request->validate([
            'course_ids' => 'required|array',
            'course_ids.*' => 'exists:courses,id'
        ]);
        $student->courses()->sync($request->course_ids);
        return $student->load('courses');
    }
}
