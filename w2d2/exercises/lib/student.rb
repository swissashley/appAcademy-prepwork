# ## Student
# * `Student#initialize` should take a first and last name.
# * `Student#name` should return the concatenation of the student's
#   first and last name.
# * `Student#courses` should return a list of the `Course`s in which
#   the student is enrolled.
# * `Student#enroll` should take a `Course` object, add it to the
#   student's list of courses, and update the `Course`'s list of
#   enrolled students.
#     * `enroll` should ignore attempts to re-enroll a student.
# * `Student#course_load` should return a hash of departments to # of
#   credits the student is taking in that department.
#

class Student
    attr_accessor :first_name, :last_name, :courses
    def initialize(first_name, last_name)
        @first_name = first_name
        @last_name = last_name
        @courses = []
    end
    
    def name
        "#{@first_name} #{@last_name}"
    end
    
    def enroll(course)
        if !@courses.include?course
            @courses.each {|another_course|
                raise "Conflict course!" if another_course.conflicts_with?(course)
            }
            course.students << self
            @courses << course
        end
    end
    
    def course_load
        map = Hash.new(0)
        @courses.each {|course|
            map[course.department] += course.credits
        }
        map
    end
        
end
