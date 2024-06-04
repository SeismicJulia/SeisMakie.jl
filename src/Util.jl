# Creates an Axis object to be used by SeisColor, SeisOverlay, SeisWiggle.
function __create_axis(fig)
    return Axis(fig, yreversed=true, xautolimitmargin=(0,0), yautolimitmargin=(0,0))
end

# Calculates the endpoints for pclip
function __calculate_pclip(A::AbstractArray{<:Real}; pclip=98)
    if (pclip<=100)
        a = -quantile(abs.(A[:]), (pclip/100))
    else
        a = -quantile(abs.(A[:]), 1)*pclip/100
    end
    b = -a

    return a, b
end