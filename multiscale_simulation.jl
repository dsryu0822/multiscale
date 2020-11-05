if length(ARGS) == 0
    push!(ARGS, "hard test") 
    error("tag not found")
end # push!(ARGS, "")

cd("C:\\Users\\rmsms\\OneDrive\\lab\\Multiscale")

@time using LightGraphs
@time using Statistics
@time using Base.Threads
@time using Dates
@time using Random
@time using Distributions
@time using LinearAlgebra
@time using Distances
@time using Plots
# include("Configuration Model.jl")
NOW = Dates.now()
println(Dates.now())
println("package loading complete")


function happen(threshold::Float64)
    if 0. <= threshold <= 1.
        return (rand(1)[1] < threshold)
    else
        throw("happen function error : wrong probability")
    end
end

function simulation(new_folder, seed, tag;
    σ = 0.5, β_A = 0.9, β_B = 0.015, p = 0.5, γ_A = 0.2,
    N = 5 * 10^4)

     # number of individuals
    backbone_size = 1000 # size of barabasi_albert network
    m_0 = 20 # initial hub size, barabasi_albert
    m = 3 # number of new link, barabasi_albert

    Random.seed!(seed)
    if seed == 0
        report = open(new_folder * "\\report " * string(seed) * ".txt", "a")

        println(report, "backbone size = $backbone_size")
        println(report, "m_0 = $m_0")
        println(report, "m = $m")
        println(report, "N = $N")
        println(report, "σ = $σ")
        println(report, "p = $p")
        println(report, "β_A = $β_A")
        println(report, "γ_A = $γ_A")
        println(report, "β_B = $β_B")
        println(report, "tag : $tag")

        time_histogram = open(new_folder * "\\time_histogram " * string(seed) * ".csv", "a")
    end

    if seed < 11
        time_evolution = open(new_folder * "\\time_evolution " * string(seed) * ".csv", "a")
        println(time_evolution,"t, I_A, I_B, R_B, V, hub_I_B")
    end

    layerA = erdos_renyi(N, 5N)
    layerC = barabasi_albert(backbone_size, m_0, m, complete = true)

    N = nv(layerA)
    M = nv(layerC)

    local stateA = ['S' for _ in 1:N]
    local stateB = ['S' for _ in 1:N]
    local location = [rand(1:M) for _ in 1:N]
    local host_ID = rand(1:N)

    local hub_I = 0
    local comp_I = 0

    local hub_I_1 = 0
    local hub_I_2 = 0
    local hub_I_3 = 0
    local hub_I_4 = 0
    local hub_I_5 = 0
    local hub_I_6 = 0
    local hub_I_7 = 0
    local hub_I_8 = 0
    local hub_I_9 = 0
    local hub_I_10 = 0

    local hub_V_1 = 0
    local hub_V_2 = 0
    local hub_V_3 = 0
    local hub_V_4 = 0
    local hub_V_5 = 0
    local hub_V_6 = 0
    local hub_V_7 = 0
    local hub_V_8 = 0
    local hub_V_9 = 0
    local hub_V_10 = 0

    t = 0
    if seed == 0
        # k_B = [sum(location .== j) for j in 1:M]
        # k_B = replace(replace(string(k_B), "[" => ""), "]" => "")
        k_C = length.(layerC.fadjlist)
        k_C = replace(replace(string(k_C), "[" => ""), "]" => "")
        println(time_histogram, k_C)
    end

    # preiteration
    if σ != 0.0
        for t in (1:Int(round(10+3/(σ+0.05))))
            for i in (1:N)
                if happen(σ) & (Int64[] != layerC.fadjlist[location[i]])
                    location[i] = rand(layerC.fadjlist[location[i]])
                end
            end
        end
    end

    if seed == 0
        location[host_ID] = 1
    end

    stateB[host_ID] = 'I'
    stateA[host_ID] = 'I'
    host_k_B = sum(location.==location[host_ID])
    host_k_C = length(layerC.fadjlist[location[host_ID]])

    if seed == 0
        println(report, "host ID : $host_ID")
        println(report, "host location : ", location[host_ID])
        println(report, "host degree of layerB : $host_k_B")
        println(report, "host degree of layerC : $host_k_C")
    end

    # while t < 30
    while sum(stateB .== 'I') != 0
        t = t + 1
        if t != 1
            for i in (1:N)
                if happen(σ) & (Int64[] != layerC.fadjlist[location[i]])
                    location[i] = rand(layerC.fadjlist[location[i]])
                end
            end
        end

        if t == 1
            hub_I_1 = sum((stateB .== 'I') .& (location .< 21))
        elseif t == 2
            hub_I_2 = sum((stateB .== 'I') .& (location .< 21))
        elseif t == 3
            hub_I_3 = sum((stateB .== 'I') .& (location .< 21))
        elseif t == 4
            hub_I_4 = sum((stateB .== 'I') .& (location .< 21))
        elseif t == 5
            hub_I_5 = sum((stateB .== 'I') .& (location .< 21))
        elseif t == 6
            hub_I_6 = sum((stateB .== 'I') .& (location .< 21))
        elseif t == 7
            hub_I_7 = sum((stateB .== 'I') .& (location .< 21))
        elseif t == 8
            hub_I_8 = sum((stateB .== 'I') .& (location .< 21))
        elseif t == 9
            hub_I_9 = sum((stateB .== 'I') .& (location .< 21))
        elseif t == 10
            hub_I_10 = sum((stateB .== 'I') .& (location .< 21))
        end
        if t == 1
            hub_V_1 = sum((stateB .== 'V') .& (location .< 21))
        elseif t == 2
            hub_V_2 = sum((stateB .== 'V') .& (location .< 21))
        elseif t == 3
            hub_V_3 = sum((stateB .== 'V') .& (location .< 21))
        elseif t == 4
            hub_V_4 = sum((stateB .== 'V') .& (location .< 21))
        elseif t == 5
            hub_V_5 = sum((stateB .== 'V') .& (location .< 21))
        elseif t == 6
            hub_V_6 = sum((stateB .== 'V') .& (location .< 21))
        elseif t == 7
            hub_V_7 = sum((stateB .== 'V') .& (location .< 21))
        elseif t == 8
            hub_V_8 = sum((stateB .== 'V') .& (location .< 21))
        elseif t == 9
            hub_V_9 = sum((stateB .== 'V') .& (location .< 21))
        elseif t == 10
            hub_V_10 = sum((stateB .== 'V') .& (location .< 21))
        end

        if seed < 11
            k_B = [sum(location .== j) for j in 1:M]
            print(time_evolution, t, ", ")

            print(time_evolution, sum(stateA .== 'I'), ", ")

            print(time_evolution, sum(stateB .== 'I'), ", ")
            print(time_evolution, sum(stateB .== 'R'), ", ")
            print(time_evolution, sum(stateB .== 'V'), ", ")

            print(time_evolution, sum((stateB .== 'I') .& (location .< 21)), ", ")

            print(time_evolution, "\n")
        end
        if seed == 0
            k_B = replace(replace(string(k_B), "[" => ""), "]" => "")
            println(time_histogram, k_B)
        end

        normalDist = Normal(0,0.05)
        uniformDdist = Uniform(0,1)
        for i in 1:20
            walker = (1:N)[location .== i]

            m = length(walker)
            coordinate = rand(uniformDdist, m, 2)
            for j in 1:10
                coordinate = mod.(coordinate + rand(normalDist, m, 2), 1)
                contact = 0.0 .< pairwise(Euclidean(), coordinate; dims=1) .< 0.1

                # 그림 그리기
                if (i == location[host_ID]) & (seed == -1) & (t == 1)
                    shaping = Array{Symbol,1}(undef, m)
                    shaping[stateB[walker] .== 'R'] .= :xcross
                    shaping[stateB[walker] .== 'S'] .= :circle
                    shaping[stateB[walker] .== 'T'] .= :rect
                    shaping[stateB[walker] .== 'I'] .= :star5
                    coloring = Array{Symbol,1}(undef, m)
                    coloring[stateB[walker] .== 'R'] .= :black
                    coloring[stateB[walker] .== 'S'] .= :green
                    coloring[stateB[walker] .== 'T'] .= :orange
                    coloring[stateB[walker] .== 'I'] .= :red
                    png(scatter(
                    coordinate[:,1], coordinate[:,2],
                    size = (800,800),
                    xlims = (0,1),
                    ylims = (0,1),
                    markershape = shaping,
                    markercolor = coloring,
                    markersize = 8,
                    markerstrokecolor = :black,
                    ), new_folder * "\\" * "$j.png")
                end

                for k in 1:m
                    infect = sum(contact[k,:] .* (stateB .== 'I')[walker])
                    if (stateB[walker[k]] == 'S') & (infect > 0) & happen(β_B)
                        stateB[walker[k]] = 'T'
                        stateA[walker[k]] = 'T'
                        # println(k, " is infected!")
                    end
                end
            end
        end

        local nA = [sum(stateA[layerA.fadjlist[i]] .== 'I') for i in 1:N]
        local π_A = [1 - (1 - β_A)^nA[i] for i in 1:N]

        local nB = [sum(stateB[location .== j] .== 'I') for j in 1:M]
        local π_B = [1 - (1 - β_B)^nB[j] for j in 1:M]

        for i in (1:N)[((π_A .+ π_B[location]) .> 0) .& (location .> 20)]
            if (stateA[i] == 'S') & (stateB[i] == 'S')
                if happen(π_A[i]/(π_A[i] + π_B[location[i]]))
                    if happen(π_A[i])
                        stateA[i] = 'T'
                    end
                    if happen(p) & (stateA[i] == 'T')
                        stateB[i] = 'U'
                    end
                else
                    if happen(π_B[location[i]])
                        stateB[i] = 'T'
                        stateA[i] = 'T'
                    end
                end
            elseif (stateA[i] == 'I') & (stateB[i] == 'S')
                if happen(π_B[location[i]])
                    stateB[i] = 'T'
                    stateA[i] = 'T'
                end
            end
        end

        for i in (1:N)[(stateA .== 'I') .| (stateB .== 'V')]
            if happen(γ_A)
                if stateA[i] == 'I'
                    stateA[i] = 'S'
                end
                if stateB[i] == 'V'
                    stateB[i] = 'S'
                end
            end
        end

        stateA[stateA .== 'T'] .= 'I'
        stateB[stateB .== 'U'] .= 'V'

        # stateA[stateA .== 'I'] .= 'S'
        # stateA[stateA .== 'T'] .= 'I'
        #
        # stateB[stateB .== 'V'] .= 'S'
        # stateB[stateB .== 'U'] .= 'V'

        stateB[stateB .== 'I'] .= 'R'
        stateB[stateB .== 'T'] .= 'I'
    end

    if seed == 0
        close(report)
        close(time_histogram)
    end
    if seed < 11
        close(time_evolution)
    end

    hub_I = max(hub_I_1, hub_I_2, hub_I_3, hub_I_4, hub_I_5, hub_I_6, hub_I_7, hub_I_8, hub_I_9, hub_I_10)

    # return [t, sum(stateA .== 'I'), sum(stateB .== 'R'), sum(stateB .== 'V'), hub_I, comp_I]
    return [seed, t, sum(stateA .== 'I'), sum(stateB .== 'R'), sum(stateB .== 'V'), hub_I,
    hub_I_1, hub_I_2, hub_I_3, hub_I_4, hub_I_5, hub_I_6, hub_I_7, hub_I_8, hub_I_9, hub_I_10,
    hub_V_1, hub_V_2, hub_V_3, hub_V_4, hub_V_5, hub_V_6, hub_V_7, hub_V_8, hub_V_9, hub_V_10]
end

#---
itr = 10
println("itr : ", itr)
println("number of threads : ", nthreads())

#---

# seed = [0]
# new_folder = string(NOW)[3:10] * "@" * string(NOW)[12:13] * "-" *
#  string(NOW)[15:16] * " (" * string(seed[1]) * ")";
# mkdir(new_folder)
#
# meta_data = open(new_folder * "\\meta_data " * string(seed[1]) * ".csv", "a")
# # println(meta_data,"t, I_A, R_B, V, hub_I, comp_I")
# println(meta_data,"seed, t, I_A, R_B, V, hub_I, hub_I_1, hub_I_2, hub_I_3, hub_I_4, hub_I_5, hub_I_6, hub_I_7, hub_I_8, hub_I_9, hub_I_10, hub_V_1, hub_V_2, hub_V_3, hub_V_4, hub_V_5, hub_V_6, hub_V_7, hub_V_8, hub_V_9, hub_V_10")
#
# r = Array{Array{Int64,1},1}()
# # simulation(new_folder, 0, tag = ARGS[1])
# @threads for itr0 in 0:itr
#     push!(r,simulation(new_folder, itr0, ARGS[1], β_A = 0.7, γ_A = 0.2))
#     # push!(r,simulation(new_folder, itr0, tag = ARGS[1]))
#     println(meta_data, replace(replace(string(r[end]), "[" => ""), "]" => ""))
#     print("|")
# end
# println("")
#
# close(meta_data)

#---

parameter_length = 20
seed = rand(10000:99999,21)
change = (0:parameter_length)/parameter_length
@time for t in 1:21
    print(seed[t])
    new_folder = "prmt=" * string(change[t]) * "..." * string(NOW)[3:10] * "@" * string(NOW)[12:13] * "-" *
     string(NOW)[15:16] * " (" * string(seed[t]) * ")";
    mkdir(new_folder)

    meta_data = open(new_folder * "\\meta_data " * string(seed[t]) * ".csv", "a")
    println(meta_data,"seed, t, I_A, R_B, V, hub_I, hub_I_1, hub_I_2, hub_I_3, hub_I_4, hub_I_5, hub_I_6, hub_I_7, hub_I_8, hub_I_9, hub_I_10, hub_V_1, hub_V_2, hub_V_3, hub_V_4, hub_V_5, hub_V_6, hub_V_7, hub_V_8, hub_V_9, hub_V_10")

    r = Array{Array{Int64,1},1}()
    # simulation(new_folder, 0, p = change[t])
    # simulation(new_folder, 0, σ = change[t])
    @threads for itr0 in 0:itr
        push!(r,simulation(new_folder, itr0, ARGS[1], β_A = change[t], γ_A = 0.2))
        # push!(r,simulation(new_folder, itr0, p = change[t] , σ = parse(Float64, ARGS[1])))
        println(meta_data, replace(replace(string(r[end]), "[" => ""), "]" => ""))
        print("|")
    end
    println("")

    close(meta_data)
end