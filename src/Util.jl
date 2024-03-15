# Creates an Axis object to be used by SeisColor, SeisOverlay, SeisWiggle.
function __create_axis(fig)
    return Axis(fig, yreversed=true, xautolimitmargin=(0,0), yautolimitmargin=(0,0))
end