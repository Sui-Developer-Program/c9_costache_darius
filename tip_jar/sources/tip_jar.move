module tip_jar::tip_jar;
// numele pachetului :: numele modulului
use sui::sui::SUI;
use sui::coin::Coin;

public struct TipJar has key{
    id: UID,
    amount:u64,
    no_of_tips:u64,
    owner: address,
}

fun init(ctx: &mut TxContext) {
   let tip_jar = TipJar {
    id: object::new(ctx), // creeaza un nou UID
    amount:0,
    no_of_tips:0,
    owner: ctx.sender(), //adresa celui care initiaza tranzactia
   };
   sui::transfer::share_object(tip_jar); // transfera obiectul creat in contul celui care a initiat tranzactia
}


public fun tip(tip_jar: &mut TipJar, payment: Coin<SUI>, _ctx: &mut TxContext) {
    tip_jar.no_of_tips = tip_jar.no_of_tips + 1;
    tip_jar.amount= tip_jar.amount + payment.balance().value();

    sui::transfer::public_transfer(payment, tip_jar.owner); // transfera banii din coin in contul owner-ului
}

