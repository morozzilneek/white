/obj/item/weapon/storage/internal/implant
	name = "bluespace pocket"
	max_w_class = 3
	max_combined_w_class = 6
	cant_hold = list(/obj/item/weapon/disk/nuclear)
	silent = 1


/obj/item/weapon/implant/storage
	name = "storage implant"
	desc = "Stores up to two big items in a bluespace pocket."
	icon_state = "storage"
	origin_tech = "materials=2;magnets=4;bluespace=5;syndicate=4"
	item_color = "r"
	var/obj/item/weapon/storage/internal/implant/storage

/obj/item/weapon/implant/storage/New()
	..()
	storage = new /obj/item/weapon/storage/internal/implant(src)

/obj/item/weapon/implant/storage/activate()
	storage.MouseDrop(imp_in)

/obj/item/weapon/implant/storage/removed(source, silent = 0, special = 0)
	if(..())
		if(!special)
			storage.close_all()
			for(var/obj/item/I in storage)
				storage.remove_from_storage(I, get_turf(source))
		return 1

/obj/item/weapon/implant/storage/implant(mob/living/carbon/source, mob/user, silent = 0)
	for(var/X in source.implants)
		if(istype(X, type))
			var/obj/item/weapon/implant/storage/imp_e = X
			imp_e.storage.storage_slots += storage.storage_slots
			imp_e.storage.max_combined_w_class += storage.max_combined_w_class
			imp_e.storage.contents += storage.contents

			storage.close_all()
			storage.show_to(source)

			qdel(src)
			return 1

	return ..()

/obj/item/weapon/implanter/storage
	name = "implanter (storage)"

/obj/item/weapon/implanter/storage/New()
	imp = new /obj/item/weapon/implant/storage(src)
	..()
