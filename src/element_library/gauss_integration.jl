function gauss_bar(ngp)
    # information on gauss for bar elements
    w = zeros(ngp,)
    z = zeros(ngp,)
    
    if  ngp == 1
        z[1] = 0
        w[1] = 2

    elseif ngp == 2
        z[1] = -0.5773502691896257
        z[2] = 0.5773502691896257
        w[1] = 1
        w[2] = 1

    elseif ngp == 3
        z[1] = -0.7745966692414834
        z[2] = 0
        z[3] = 0.7745966692414834
        w[1] = 0.5555555555555556
        w[2] = 0.8888888888888888
        w[3] = 0.5555555555555556

    elseif ngp == 4
        z[1] = -0.3399810435848563
        z[2] = 0.3399810435848563
        z[3] = -0.8611363115940526
        z[4] = 0.8611363115940526

        w[1] = 0.6521451548625461
        w[2] = 0.6521451548625461
        w[3] = 0.3478548451374538
        w[4] = 0.3478548451374538

    else
        throw("Number of Gauss points not supported")
    end

    return (z,w)
end

function gauss_quad(ngp)
    # information on gauss points for quadrilateral elements
    z = zeros(2,ngp)
    if ngp == 1
        (zbar,w) = gauss_bar(ngp)
        fill!(z,zbar[1])
        
    elseif ngp == 4
        (zbar,w) = gauss_bar(ngp/2)
        z = [zbar[1] zbar[2] zbar[2] zbar[1];
             zbar[1] zbar[1] zbar[2] zbar[2]]
    else
        throw("Number of Gauss points not supported")
    end

    return (z,w)
end

function gauss_triang(ngp)
    # information on gauss points for triangular elements
    w = zeros(ngp)
    z = zeros(2,ngp)

    if ngp == 0 
        throw("Invalid number of Gauss Points")

    elseif  ngp == 1
        z[1,1] = 0.33333333333333333333 
        z[2,1] = 0.33333333333333333333 
        w[1] = 1

    elseif ngp == 3
        z[1,1] = 0.66666666666666666667
        z[1,2] = 0.16666666666666666667
        z[1,3] = 0.16666666666666666667
        z[2,1] = 0.16666666666666666667
        z[2,2] = 0.66666666666666666667
        z[2,3] = 0.16666666666666666667
        
        w[:] = 0.33333333333333333333
        
    elseif ngp == 6
        z[1,1] = 0.659027622374092
        z[1,2] = 0.659027622374092 
        z[1,3] = 0.231933368553031
        z[1,4] = 0.231933368553031
        z[1,5] = 0.10903900907287
        z[1,6] = 0.109039009072877
        z[2,1] = 0.231933368553031
        z[2,2] = 0.109039009072877
        z[2,3] = 0.659027622374092
        z[2,4] = 0.109039009072877
        z[2,5] = 0.659027622374092
        z[2,6] = 0.231933368553031
        
        w[:] = 0.16666666666666666667
    else
        throw("Number of Gauss points not supported")
    end

    return (z,w)
end
