module guestbook::guestbook;

use std::string::String;

public struct Message has store {
    content: String,
    sender: address,
}

public struct Guestbook has key {
    id: UID,
    no_of_messages: u64,
    messages: vector<Message>,
}

fun init(ctx: &mut TxContext) {
    let guestbook = Guestbook {
        id: object::new(ctx),
        no_of_messages: 0,
        messages: vector::empty<Message>(),
    };

    sui::transfer::share_object(guestbook);
}
public fun add_message(guestbook: &mut Guestbook, message: Message) {
    guestbook.no_of_messages = guestbook.no_of_messages + 1;
    guestbook.messages.push(message);
}


public fun create_message(content: String, ctx: &mut TxContext): Message {
    Message {
        content,
        sender: ctx.sender(),
    }
}
