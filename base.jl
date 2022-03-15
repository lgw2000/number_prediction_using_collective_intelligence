module base_things
    mutable struct 변수
        input_num::Float64
        Weight::Float64
        real_num::Float64
        abs_error::Float64
        minus_weight ::Float64
    end

    function abs_error_cal(var)::Float64
        var.abs_error = abs(var.input_num - var.real_num)
        return var.abs_error
    end

    function forward(var,sum_of_W)
        percent_of_W = var.Weight/sum_of_W
        out = var.input_num*percent_of_W
        out
    end

    function graph(add,max,avg)
        if  add > avg
            return -(1.5+(add*avg))
        else
            y = cos((10.0*add)/(π*max)) - avg*add
        return y
        end
    end

    function backward(var,new_w)
        new_v = var.Weight + var.minus_weight + new_w
        if new_v < 0
            var.minus_weight = new_v
            var.Weight = 0
            return var.Weight , var.minus_weight
        else
            return new_v , 0
        end
    end

    

end
