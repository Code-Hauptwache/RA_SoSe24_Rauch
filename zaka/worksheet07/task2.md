# Aufgabe 7.2
![image](https://github.com/Code-Hauptwache/RA_SoSe24_Rauch/assets/103366844/9e4c0b99-3932-4bba-b2a8-42e4feffd239)

## `func1`
- **Instuctionwords in binary:**
    ```
    func1:  001000 00000 01000 1111111111111111
    p:      000000 00101 01000 01000 00000 000100
    q:      000000 00100 01000 00010 00000 100100
    r:      000000 11111 0000000000 00000 001000
    ```
- **Instructionwords in MARS assembler sytax:**
    ```asm
    func1:  addi  $t0, $zero, -1
    p:      sllv  $t0, $t0, $a1
    q:      and   $v0, $a0, $t0
    r:      jr    $ra
    ```

## `func2`
- **Instuctionwords in binary:**
    ```
    func2:  001000 00000 01000 0000000000000001
    p:      001000 00000 00010 1111111111111111
    q:      000000 00100 01000 01001 00000 100100
    r:      001000 00010 00010 0000000000000001
    s:      000000 00000 01000 01000 00001 000000
    t:      000101 01001 00000 1111111111111100
    u:      000000 11111 0000000000 00000 001000
    ```
- **Instructionwords in MARS assembler sytax:**
    ```asm
    func2:  addi  $t0, $zero, 1
    p:      addi  $v0, $zero, -1
    q:      and   $t1, $a0, $t0
    r:      addi  $v0, $v0, 1
    s:      sll   $t0, $t0, 1
    t:      bne   $t1, $zero, q
    u:      jr    $ra
    ```

![image](https://github.com/Code-Hauptwache/RA_SoSe24_Rauch/assets/103366844/c9a9c84a-2612-4e73-9b55-c99bc50ba869)

## `func1`
![image](https://github.com/Code-Hauptwache/RA_SoSe24_Rauch/assets/103366844/ec369840-b8f9-4848-9006-ce82ef5a5f57)

## `func2`
![image](https://github.com/Code-Hauptwache/RA_SoSe24_Rauch/assets/103366844/8d8ad77e-63e0-408e-bc43-760a641d1cc9)

![image](https://github.com/Code-Hauptwache/RA_SoSe24_Rauch/assets/103366844/9475f9bf-4f37-40ba-a313-737332c7b6fd)

## `func1`
1. `addi  $t0, $zero, -1`: Initializes `$t0` to all 1s.
2. `sllv  $t0, $t0, $a1`: Shifts `$t0` left by the number of bits in `$a1`, creating a mask.
3. `jr    $ra`: Masks `$a0` with this shifted value, storing the result in `$v0`.

The subroutine `func1` masks out the lower bits of `$a0` according to the number of bits specified in `$a1`, setting those bits to 0, and returns the result in $v0.


## `func2`
1. `addi  $t0, $zero, 1`: Initialize `$t0` to 1 (bitmask).
2. `addi  $v0, $zero, -1`: Initialize `$v0` to -1 (will be used as a counter).
3. `and   $t1, $a0, $t0`: Perform bitwise AND between `$a0` and `$t0`, store result in `$t1`.
4. `addi  $v0, $v0, 1`: Increment `$v0` by 1.
5. `sll   $t0, $t0, 1`: Shift `$t0` left by 1 bit.
6. `bne   $t1, $zero, q`: If `$t1` is not zero, branch back to label `q`.
7. `jr    $ra`: Return from subroutine.

The subroutine `func2` counts and returns the number of 1 bits in the input value provided in register `$a0`. The count is returned in register `$v0`.
