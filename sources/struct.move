module MyAddr::Fellow{
    use std::debug;
        struct Empty{}
    
        // copy, drop, key, store
        // copy duplication
        // drop removing
        // key & store - key-value pair 
        struct Fellow has drop{
            id:u64,
            age:u8,
            build_in_bear:bool
        }

        //generic struct
        struct MyClass<t1,t2> has drop{
            quality:t1,
            learning:t2,
        }

        //public constructor
        public fun new_fellow(id:u64, age:u8, bib:bool):Fellow
        {
            return Fellow{id,age,build_in_bear:bib}
        }

        //public constructormovelang debug print
        public fun new_class<t1,t2>(quality:t1, learning:t2):MyClass<t1,t2>
        {
            return MyClass{quality, learning}
        }

        public fun get_id(f: Fellow): u64{
            return f.id
        }

        #[test(account = @0x1)]
        public entry fun script_fn(){
            let f = MyAddr::Fellow::new_fellow(5000,23,false);
            let id = f.id;
            //let id = MyAddr::Fellow::get_id(f);
            debug::print(&id);
        }

        #[test(account = @0x1)]
        public entry fun script_fn_generic(){
            let class = MyAddr::Fellow::new_class(10,10);
            let quality = class.quality;
            debug::print(&quality);
        }

    }