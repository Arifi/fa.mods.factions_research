--UEF ACU

local oldUEL0001 = UEL0001
UEL0001 = Class(oldUEL0001) {

	OnCreate = function(self)
		oldUEL0001.OnCreate(self)
		--ACUUnit.OnCreate(self)
		self:AddBuildRestriction(categories.CYBRAN)
	end,

    CreateEnhancement = function(self, enh)
        oldUEL0001.CreateEnhancement(self, enh)
		
		local bp = self:GetBlueprint().Enhancements[enh]
        if not bp then return end
		
        if enh =='CybranEngineering' then
            local cat = ParseEntityCategory(bp.BuildableCategoryAdds)
            self:RemoveBuildRestriction(cat)
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
        elseif enh =='CybranEngineeringRemove' then
            local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
            self:RestoreBuildRestrictions()
            self:AddBuildRestriction( categories.UEF * (categories.BUILTBYTIER2COMMANDER + categories.BUILTBYTIER3COMMANDER) )
            self:AddBuildRestriction( categories.UEF * (categories.BUILTBYTIER2COMMANDER + categories.BUILTBYTIER3COMMANDER) )
            self:AddBuildRestriction(categories.CYBRAN)
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
		end
    end,
}

TypeClass = UEL0001
