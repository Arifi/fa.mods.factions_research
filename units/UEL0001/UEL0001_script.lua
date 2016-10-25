--UEF ACU

local oldUEL0001 = UEL0001
UEL0001 = Class(oldUEL0001) {

	-- ********
    -- Creation
    -- ********
    OnCreate = function(self)
        oldUEL0001.OnCreate(self)
        
        -- Restrict what enhancements will enable later
        --self:AddBuildRestriction( categories.UEF * (categories.BUILTBYTIER2COMMANDER + categories.BUILTBYTIER3COMMANDER) )
		self:RemoveBuildRestriction( categories.UEF)
		self:AddBuildRestriction( categories.CYBRAN )
    end,
	
    CreateEnhancement = function(self, enh)
        oldUEL0001.CreateEnhancement(self, enh)
        --Cybran Engineering
        if enh =='CybranEngineering' then
            local bp = self:GetBlueprint().Enhancements[enh]
            if not bp then return end
            local cat = ParseEntityCategory(bp.BuildableCategoryAdds)
            self:RemoveBuildRestriction(cat)
			-- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
			self:updateBuildRestrictions()
		elseif enh =='CybranEngineeringRemove' then
            local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
            self:RestoreBuildRestrictions()
            self:AddBuildRestriction( categories.CYBRAN )
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
        else
    end,

}


