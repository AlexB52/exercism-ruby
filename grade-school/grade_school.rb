class Students
  Student = Struct.new(:name, :grade)

  def initialize
    @collection = []
  end

  def for_grade(grade)
    @collection.select { |student| student.grade == grade }
  end

  def add(student, grade)
    @collection << Student.new(student, grade)
    @collection.sort_by!(&:name)
  end

  def students_by_grade
    @collection.sort_by(&:grade).group_by(&:grade)
  end
end

class School
  attr_reader :students_repository

  def initialize(students: Students.new)
    @students_repository = students
  end

  def students(grade)
    students_repository.for_grade(grade).map(&:name)
  end

  def add(student, grade)
    students_repository.add(student, grade)
  end

  def students_by_grade
    students_repository.students_by_grade.map do |grade, students|
      { grade: grade, students: students.map(&:name) }
    end
  end
end