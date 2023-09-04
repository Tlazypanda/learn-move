module MyAddr::Math{
    use aptos_std::debug;

    public fun sum(a:u8, b:u8):u8{
        (a+b)
    }

    public fun sum_incomp(a:u64, b:u8):u64{
        (a+ (b as u64))
    }

    public fun max(a:u8, b:u8):u8{
        if(a>b)
        {a}
        else{b}
    }

    public fun whilen(n:u8):u8{
        let i:u8=1;
        let sum:u8=0;
        while(i<=n){
            sum = sum + i;
            i = i+1;
        };
        sum    
    }

    public fun sub(a:u8, b:u8):u8{
        (a-b)
    }

    public fun mul(a:u8, b:u8):u8{
        (a*b)
    }

    public fun div(a:u8, b:u8):u8{
        (a/b)
    }

    #[test(account = @0x1)]
    public entry fun calc(){
        let c:u8 = sum(6,5);
        debug::print<u8>(&c)
    }

    #[test(account = @0x1)]
    public entry fun calc1(){
        let c:u64 = sum_incomp(266,5);
        debug::print<u64>(&c)
    }

    #[test(account = @0x1)]
    public entry fun whiletest(){
        let c:u8 = whilen(13);
        debug::print<u8>(&c)
    }
    
}