<?php

use App\Http\Controllers\CourseController;
use App\Http\Controllers\StudentController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::apiResource('students', StudentController::class);
Route::post('students/{id}/assign-courses', [StudentController::class, 'assignCourses']);
Route::apiResource('courses', CourseController::class);
