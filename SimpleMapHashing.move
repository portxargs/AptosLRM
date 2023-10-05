module  my_addrx::simplemaplrm {
    use std::hash;
    use std::bcs;
    use std::debug::print;
    use std::string::{String,utf8};
    use std::simple_map::{SimpleMap,Self};
    use std::vector;
    use std::error;
    use std::option;

//creating SimpleMap with hashed values

    
    fun return_map(): SimpleMap<String,vector<u8>> {

            let mp:SimpleMap<String,vector<u8>> = simple_map::create();
                simple_map::add(&mut mp,utf8(b"Harry"),hash::sha2_256(bcs::to_bytes<String>(&utf8(b"Team1")))); 
                simple_map::add(&mut mp,utf8(b"John"),hash::sha2_256(bcs::to_bytes<String>(&utf8(b"Team1")))); 
                simple_map::add(&mut mp,utf8(b"Drew"),hash::sha2_256(bcs::to_bytes<String>(&utf8(b"Team2")))); 
                simple_map::add(&mut mp,utf8(b"Leela"),hash::sha2_256(bcs::to_bytes<String>(&utf8(b"Team2")))); 
            mp
    }

//Adding an entry to the existing SimpleMap and returning the updated SimpleMap
    #[view]
    public fun map_add(c:String,d:String): SimpleMap<String,vector<u8>>{
        let tmp=return_map();    
        simple_map::add(&mut tmp,c,hash::sha2_256(bcs::to_bytes<String>(&d))); 
        tmp
    }


//Check if a user(key) is in the SimpleMap
    #[view]
    public fun contains_user(a:String): bool
    {
        //let tmp=map_add(utf8(b"Sandra"),utf8(b"Team3"));
        let tmp=return_map();
        let b=simple_map::contains_key(&mut tmp,&a);
        b
    }

//Check if user/team(key/value) pair is in SimpleMap
    #[view]
    public fun check_userteam(x:String, y:String): bool
    {
        let tmp=return_map();
        let z = hash::sha2_256(bcs::to_bytes<String>(&y));
        if (simple_map::contains_key(&mut tmp,&x) == false) false else 
        if (simple_map::borrow(&mut tmp,&x)==&z) true else false
    }

}
    
    
    
