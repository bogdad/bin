line1 = STDIN.gets()
line2 = STDIN.gets()

N,k = line1.split(" ")
N = N.to_i
k = k.to_i
numbers = line2.split()

numbers = numbers.map(&:to_i)

numbers = numbers.sort()

# CLONE
first = numbers.clone
first.shift

#CLONE
second = numbers.clone
second.pop

diff = first.zip(second).map{|x,y| x-y}

#puts "radix end"
diff = []
i = 0
#puts "numbers " + numbers.to_s
while  i < numbers.length-1 do
   diff << (numbers[i+1]-numbers[i])
   i = i + 1
end


#puts diff
i = 0
j = 0
curSum = 0
num = 0
#puts "diffs="+diff.to_s
while true do
    #puts "i="+i.to_s+" j=" + j.to_s+" sum="+curSum.to_s
    if curSum > k
            shouldIncI = true
     elsif curSum == k
        num +=1
        shouldIncI = true
    else
        shouldIncJ = true
    end
    if shouldIncI
        curSum -= diff[i]
        i = i + 1
    end
    if i == j
        shouldIncJ = true
    end
    if shouldIncJ
        curSum += diff[j]
        j = j + 1
    end
    if i == diff.length
        break
    end
    if j == diff.length
        break
    end
end

STDOUT.write(num)
