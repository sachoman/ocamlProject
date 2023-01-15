type 'a priorityQueue

val vide : 'a priorityQueue

val inserer : 'a ->int ->'a priorityQueue -> 'a priorityQueue


val est_vide : 'a priorityQueue -> bool

val trouve_min : 'a priorityQueue -> 'a

val supprime : 'a ->'a priorityQueue -> 'a priorityQueue

val extraire_min : 'a priorityQueue -> 'a * 'a priorityQueue

val diminuer_clef : 'a -> int -> 'a priorityQueue -> 'a priorityQueue 