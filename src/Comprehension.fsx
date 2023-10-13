// F# Computation Expression for Option type
//
// dotnet fsi src/Comprehension.fsx
// #quit;;
type OptionBuilder() =
    member this.Bind(opt, f) =
        match opt with
        | Some value -> f value
        | None -> None

    member this.Return(value) =
        Some value

    member this.ReturnFrom(opt) =
        opt

let option = OptionBuilder()

let safeDivide x y =
    if y = 0.0 then None else Some (x / y)

let safeRoot x =
    if x < 0.0 then None else Some (sqrt x)

let computeResult x y z =
    option {
        let! divisionResult = safeDivide x y
        let! rooted = safeRoot divisionResult
        let! multiplied = Some (rooted * z)
        return multiplied
    }

// Test cases
printfn "%A" (computeResult 10.0 2.0 3.0);;  // Some 6.708 
printfn "%A" (computeResult 10.0 0.0 3.0);;  // None (due to division by zero)
printfn "%A" (computeResult -10.0 1.0 3.0);; // None (due to square root of negative number)
