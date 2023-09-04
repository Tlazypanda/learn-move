//resources are special type of structs which can't be copied or discarded, 
//only the key can be used to store values
//resources are stored under account

//imp: an account can hold only one resource at a time

//resources API:
//move_to<T>(&Signer, T): to give resources, will abort if account already has resource
//move_from<T>(address):T: delete T from account, will abort if account doesn't have T
//borrow_global_mut<T>(address):&mut T: borrow mutable reference 
//borrow_global<T>(address):&T: borrow immutable reference
//exists<T>(address):bool: if T exists at address, won't abort at all

//When a function accesses a resource using move_from, borrow_global, or borrow_global_mut, 
//the function must indicate that it acquires that resource. 
//This is then used by Move's type system to ensure the references into global storage are safe, 
//specifically that there are no dangling references into global storage.


module MyAddr::Colln{
    use std::vector;
    use std::signer;
    use std::debug;

    struct Item has store, drop{}

    struct Collection has store, key {
        items: vector<Item>,
    }

    public fun start_collection(account:&signer)
    {
        move_to<Collection>(account, Collection{items: vector::empty<Item>()})
    }
        //presence/absence

    public fun exists_at(at: address):bool{
        exists<Collection>(at)
    }

    public fun add_item(account: &signer) acquires Collection{
        let addr = signer::address_of(account);
        //let collection = borrow_global<Collection>(addr);
        let collection = borrow_global_mut<Collection>(addr);
        vector::push_back(&mut collection.items, Item{})
    }

    public fun size(account: &signer):u64 acquires Collection{
        let addr = signer::address_of(account);
        let collection = borrow_global<Collection>(addr);
        vector::length(&collection.items)
    }



        public fun destroy(account: &signer) acquires Collection
        {
            let addr = signer::address_of(account);
            let collection = move_from<Collection>(addr);

            let Collection{items:_} = collection;
        }

        #[test(account = @0x42)]
        public entry fun script_fn_2(account: signer) acquires Collection{
            MyAddr::Colln::start_collection(&account);
            let addr = signer::address_of(&account);
            let is = MyAddr::Colln::exists_at(addr);
            debug::print(&is);
            MyAddr::Colln::add_item(&account);
            let lsize = MyAddr::Colln::size(&account);
            debug::print(&lsize);
            MyAddr::Colln::destroy(&account);
            MyAddr::Colln::destroy(&account);
            let is = MyAddr::Colln::exists_at(addr);
            debug::print(&is);
            //MyAddr::Colln::start_collection(&account);
        }
    }