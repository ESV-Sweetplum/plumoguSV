function math.createKernel(kernelType, parameters)
    kernelType = kernelType:lower()
    if (kernelType == 'gaussian') then
        local sigma = parameters.sigma
        local radius = math.ceil(sigma * 3)
        local kernel = {}
        local sum = 0

        for i = -radius, radius do
            local val = math.exp(-(i * i) / (2 * sigma * sigma))
            kernel[i + radius + 1] = val
            sum = sum + val
        end

        local max_val = kernel[radius + 1]
        if (parameters.normalize) then max_val = sum end

        for i = 1, #kernel do
            kernel[i] = kernel[i] / max_val
        end

        return kernel, radius
    end
end
