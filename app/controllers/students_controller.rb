class StudentsController < ApplicationController

    def create
    student=Student.create(student_params)
    if student.valid?
        render json: student, status: :created
    else
        render json: {errors: student.errors.full_messages}, status: :unprocessable_entity
    end
    end


    def index
        students=Student.all 
        render json: students,status: 200
    end

    def show
    student=Student.find_by(id: params[:id])
    if student
        render json: student, status: :ok
    else
        render json: {errors: "Not found"}, status: :not_found
    end
    end

    def update
        student=Student.find_by(id: params[:id])
        if student
            student.update(student_params)
            if student.valid?
               render json: student, status: :ok
            else
                render json:{ error: student.errors.full_messages}, status: :unprocessable_entity
            end
        else
            render json: {errors: "Not found"},status: :not_found
        end
    end

    def destroy
        student=Student.find_by(id: params[:id])
        if student
            student.destroy
            head :no_content
        else
            render json: {errors: "Not found"}, status: :not_found
        end
    end

    

    private

    def student_params
    params.permit(:name, :major, :age, :instructor_id)
    end

end
