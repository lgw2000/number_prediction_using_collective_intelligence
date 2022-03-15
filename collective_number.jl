# © 2022,03,15 leegeonwoo <ace9907@naver.com>

include("./base.jl")
using .base_things
using Base



inputing = []
weighting = []
minus_weight = []

println("변수 개수(사람의 수)를 입력하시오")
println()

number_of_input = parse(Int64,readline())
println()
println("반복횟수")
number_of_loop = parse(Int64,readline())




for i = 1:number_of_input
    append!(weighting,1)
end

for i = 1:number_of_input
    append!(minus_weight,0)
end



# julia 의 배열은 1부터 시작
for start = 1:number_of_loop


    println("변수를 입력하시요")
    
    if start==1
        for i = 1:number_of_input
            append!(inputing,parse(Float64,readline()))
        end
    else
        for i = 1:number_of_input
            inputing[i] =  parse(Float64,readline())
        end
    end



    println("실제로 나온 값 입력")
    real_input = readline()
    real_input = parse(Float64,real_input)



    vari = Vector{base_things.변수}(undef,number_of_input)

    for i = 1:number_of_input
        vari[i] = base_things.변수(inputing[i],weighting[i],real_input,0,minus_weight[i])
    end



    list_abs_error = zeros(Float64,1,number_of_input)
    for i = 1:number_of_input
        list_abs_error[i] = base_things.abs_error_cal(vari[i])
    end

    max_error = maximum(list_abs_error)

    sum_of_error = sum(list_abs_error)
    len_of_error = length(list_abs_error)
    avg_of_error = sum_of_error/len_of_error

    add_list = zeros(Float64,1,number_of_input)

    for i = 1:number_of_input
        add_list[i] = 1/(sum_of_error/list_abs_error[i])
    end

    sumofw = 0


    max_add = maximum(add_list)
    sum_add = sum(add_list)
    len_add = length(add_list)
    avg_add = sum_add/len_add


    
    for i = 1:number_of_input
        sumofw = sumofw + vari[i].Weight
    end


    forwarding = zeros(Float64,1,number_of_input)

    for i = 1:number_of_input
        forwarding[i] = base_things.forward(vari[i],sumofw)
    end

    result = 0


    for i = 1:number_of_input
        result = result + forwarding[i]
    end

    println("결과치")
    println(result)
    println()

    new_weigth_list = zeros(Float64,1,number_of_input)


    for i = 1:number_of_input
        new_weigth_list[i] = base_things.graph(add_list[i],max_add,avg_add)
    end

    backwarding = zeros(Float64,1,number_of_input)

    for i = 1:number_of_input
        weighting[i] , minus_weight[i] = base_things.backward(vari[i],new_weigth_list[i])
    end

    println()
    for i = 1:number_of_input
        vari[i].minus_weight = minus_weight[i]
        vari[i].Weight = weighting[i]
    end

end