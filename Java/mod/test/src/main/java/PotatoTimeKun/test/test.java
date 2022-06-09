package PotatoTimeKun.test;

import net.minecraft.block.AbstractBlock;
import net.minecraft.block.Block;
import net.minecraft.block.SoundType;
import net.minecraft.block.material.Material;
import net.minecraft.block.material.MaterialColor;
import net.minecraft.item.BlockItem;
import net.minecraft.item.Item;
import net.minecraft.item.ItemGroup;
import net.minecraftforge.common.ToolType;
import net.minecraftforge.eventbus.api.IEventBus;
import net.minecraftforge.fml.RegistryObject;
import net.minecraftforge.fml.common.Mod;
import net.minecraftforge.fml.javafmlmod.FMLJavaModLoadingContext;
import net.minecraftforge.registries.DeferredRegister;
import net.minecraftforge.registries.ForgeRegistries;
@Mod(test.MOD_ID)
public class test {

    public static final String MOD_ID = "test";

    public test(){
        IEventBus modEventBus = FMLJavaModLoadingContext.get().getModEventBus();
        Items.register(modEventBus);
        Blocks.register(modEventBus);
    }

    public static class Blocks{
        private static final DeferredRegister<Block> BLOCKS=DeferredRegister.create(ForgeRegistries.BLOCKS,MOD_ID);
        public static final RegistryObject<Block> newblock=BLOCKS.register("newblock",() -> new Block(AbstractBlock.Properties
                .of(Material.METAL, MaterialColor.METAL)
                .requiresCorrectToolForDrops()
                .strength(5.0F,6.0F)
                .sound(SoundType.METAL)
                .harvestTool(ToolType.PICKAXE)
                .harvestLevel(1)
        ));
        public static void register(IEventBus eventBus){
            BLOCKS.register(eventBus);
        }
    }

    public static class Items{
        private static final DeferredRegister<Item> ITEMS = DeferredRegister.create(ForgeRegistries.ITEMS,MOD_ID);
        public static final RegistryObject<Item> TEST_ITEM = ITEMS.register("newitem",
                ()->new Item(new Item.Properties().tab(ItemGroup.TAB_MATERIALS)));
        public static final RegistryObject<Item> TEST_BLOCK = ITEMS.register("newblock",()->new BlockItem(Blocks.newblock.get(),new Item.Properties()
                .tab(ItemGroup.TAB_BUILDING_BLOCKS)));
        public static void register(IEventBus eventBus){
            ITEMS.register(eventBus);
        }
    }
}
