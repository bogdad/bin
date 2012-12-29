doubleMe x = x + x
doubleUs x y = x*2 +y*2

doubleSmallNumber x = if x>100
			then x
			else x*2

fib x = if x == 1 || x == 0 
	then 1
	else fib(x-1) + fib(x-2)

memoized_fib :: Int -> Integer
memoized_fib = (map fib [0 ..] !!)
   where fib 0 = 1
         fib 1 = 1
         fib n = memoized_fib (n-2) + memoized_fib (n-1)

maxfib u = maximum ([ x | x <- [1..100], memoized_fib x < u])
tpl u = (u,memoized_fib(maxfib(u)))

int_sqrt :: (Integral a, Integral b) => a -> b
int_sqrt x = floor (sqrt (fromIntegral x)) + 1 
is_prime  :: (Integral a) => a -> Bool
is_prime x = if x == 1 
		then True
		else foldr (&&) True [ x `mod` y > 0 | y <- [2..(int_sqrt x)], is_prime y ]
prime_factor :: (Integral a) => a -> [a]
prime_factor x = [ y | y <- [2..(int_sqrt x)] , is_prime y, x `mod` y == 0 ]
	
primeFactors n = primeFactors' n 2
  where
    primeFactors' 1 _ = []
    primeFactors' n f
      | n `mod` f == 0 = f : primeFactors' (n `div` f) f
      | otherwise      = primeFactors' n (f + 1)

digit_length :: (Integral a) => a -> a
digit_length x = (floor ((log (fromIntegral x)) / (log 10))) + 1

first_digit_divisor :: (Integral a) => a->a
first_digit_divisor x =  floor(exp $ (fromIntegral (digit_length x - 1) * log 10))

is_palindrome2 :: (Integral a, Integral b) => a -> b ->Bool
is_palindrome2 x y = if x < 10 
			then if y <= 1 
				then True
				else False
			else if x `div` (first_digit_divisor x) == x `mod` 10
				then is_palindrome2  (x `mod` (first_digit_divisor x) `div` 10) (y-2)
				else False

is_palindrome :: (Integral a) => a ->Bool
is_palindrome x = is_palindrome2 x (digit_length x)

to_list :: (Integral a) => a -> [a]
to_list x = if x<10
		then [x]
		else to_list (x `div` 10) ++ [x `mod` 10]

is_palindrome_fast x = is_list_palindrome $ to_list x
is_list_palindrome x =  x == reverse(x)

reverse_number2 x y = if x == 0 
			then y
			else reverse_number2 (x `div` 10)  (y*10+(x `mod` 10))
reverse_number x = reverse_number2 x 0			

is_palindrome_number x = (reverse_number x) == x

mnod a b = if b == 0
		then a
		else mnod b (a `mod` b)

--lcm a b = floor ( ( a * b ) / mnod (a b) )

minus (x:xs) (y:ys) = case (compare x y) of 
           LT -> x : minus  xs  (y:ys)
           EQ ->     minus  xs     ys 
           GT ->     minus (x:xs)  ys
minus  xs     _     = xs

primesToQ m = 2 : sieve [3,5..m]  where
    sieve []     = []
    sieve (p:xs) = p : sieve (xs `minus` [p*p, p*p+2*p..m])


tolst = 7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450


cons_product lst ind ln = map (\x -> lst!!x) [ind,ind+1..ind+ln-1]
cons_products lst ln = [ cons_product lst x | x <- [1..length(lst)-ln] ]

all_equal lst = (maximum lst) == minimum(lst)
all_equal_one lst = (maximum lst) == minimum(lst) && (maximum lst)== 1
diff lst = [ lst!!i+1 - lst!!i | i <- [0..length(lst)-2] ]
ph_h width count indices = [ [ind, ind+1 .. ind+count-1] | ind <- indices, ind `mod` count ==0]
ph width count indices = [ ind | ind <- (ph_h width count indices), (all_equal [ i `div` width | i <-ind])]
pv_h width count indices = [ [ind, ind+width .. ind+width*(count-1)] | ind <- indices, (ind `div` width) `mod` count ==0]
pv width count indices = [ ind | ind <- (pv_h width count indices), (maximum ind) `div` width < width]
pd_h width count indices = [ [ind, ind+1+width .. ind + (1+width)*(count-1)] | ind <-indices,   ]
pd width count indices = [ ind | ind <- (pd_h width count indices), (all_equal_one (diff [ i `div` width | i<-ind])) ]
productinds inds lst = product [ lst!!ind | ind <-inds]

ansinds width count lst inds = [ productinds inds lst | inds <- ( (ph width count inds) ++ (pv width count inds) ++ (pd width count inds)) ]
ans width count lst = ansinds width count lst [0..length(lst)-1] 

tolst2=[08, 02, 22, 97, 38, 15, 00, 40, 00, 75, 04, 05, 07, 78, 52, 12, 50, 77, 91, 08,49,49,99,40,17,81,18,57,60,87,17,40,98,43,69,48,04,56,62,00,81, 49, 31, 73, 55, 79, 14, 29, 93, 71, 40, 67, 53, 88, 30, 03, 49, 13, 36, 65,52,70, 95, 23, 04, 60, 11, 42, 69, 24, 68, 56, 01, 32, 56, 71, 37, 02, 36, 91,22, 31, 16, 71, 51, 67, 63, 89, 41, 92, 36, 54, 22, 40, 40, 28, 66, 33, 13, 80,24, 47, 32, 60, 99, 03, 45, 02, 44, 75, 33, 53, 78, 36, 84, 20, 35, 17, 12, 50,32, 98, 81, 28, 64, 23, 67, 10, 26, 38, 40, 67, 59, 54, 70, 66, 18, 38, 64, 70,67, 26, 20, 68, 02, 62, 12, 20, 95, 63, 94, 39, 63, 08, 40, 91, 66, 49, 94, 21,24, 55, 58, 05, 66, 73, 99, 26, 97, 17, 78, 78, 96, 83, 14, 88, 34, 89, 63, 72,21, 36, 23, 09, 75, 00, 76, 44, 20, 45, 35, 14, 00, 61, 33, 97, 34, 31, 33, 95,78, 17, 53, 28, 22, 75, 31, 67, 15, 94, 03, 80, 04, 62, 16, 14, 09, 53, 56, 92,16, 39, 05, 42, 96, 35, 31, 47, 55, 58, 88, 24, 00, 17, 54, 24, 36, 29, 85, 57,86, 56, 00, 48, 35, 71, 89, 07, 05, 44, 44, 37, 44, 60, 21, 58, 51, 54, 17, 58,19, 80, 81, 68, 05, 94, 47, 69, 28, 73, 92, 13, 86, 52, 17, 77, 04, 89, 55, 40,04, 52, 08, 83, 97, 35, 99, 16, 07, 97, 57, 32, 16, 26, 26, 79, 33, 27, 98, 66,88, 36, 68, 87, 57, 62, 20, 72, 03, 46, 33, 67, 46, 55, 12, 32, 63, 93, 53, 69,04, 42, 16, 73, 38, 25, 39, 11, 24, 94, 72, 18, 08, 46, 29, 32, 40, 62, 76, 36,20, 69, 36, 41, 72, 30, 23, 88, 34, 62, 99, 69, 82, 67, 59, 85, 74, 04, 36, 16,20, 73, 35, 29, 78, 31, 90, 01, 74, 31, 49, 71, 48, 86, 81, 16, 23, 57, 05, 54,01, 70, 54, 71, 83, 51, 54, 69, 16, 92, 33, 48, 61, 43, 52, 01, 89, 19, 67, 48]
