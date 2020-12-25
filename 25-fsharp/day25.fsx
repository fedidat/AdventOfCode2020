// let filename = "day25-sample.txt"
let filename = "day25.txt"

let input =
    System.IO.File.ReadAllLines filename
    |> Seq.map int64
    |> Seq.toList

let initial_subject_number = 7L
let starting_value = 1L
let modulus = 20201227L

let transform current subject_number = (current * subject_number) % modulus

let rec generate_keys input =
    let transformed = transform input initial_subject_number
    seq {
        yield transformed
        yield! generate_keys transformed
    }

let get_public_key public_key = 
    generate_keys starting_value 
    |> Seq.findIndex ((=) public_key)

let find_loop_size =
    1 + get_public_key input.[1]
    |> int64

let rec encrypt input loop_size subject_number =
    let tranformed = transform input subject_number
    if loop_size = 0L
    then input
    else encrypt tranformed (loop_size - 1L) subject_number

let result =
    encrypt starting_value find_loop_size input.[0]

printfn "Part 1: %i" result
