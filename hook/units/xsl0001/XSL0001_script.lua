--SERAPHIM ACU

local oldXSL0001 = XSL0001
XSL0001 = Class(oldXSL0001) {

	OnCreate = function(self)
		oldXSL0001.OnCreate(self)
		--ACUUnit.OnCreate(self)
		self:AddBuildRestriction(categories.CYBRAN)
		self:AddBuildRestriction(categories.AEON)
		self:AddBuildRestriction(categories.UEF)
	end,
	
	CreateBuildEffects = function( self, unitBeingBuilt, order )
        local UpgradesFrom = unitBeingBuilt:GetBlueprint().General.UpgradesFrom
		local faction =  unitBeingBuilt:GetBlueprint().General.FactionName
		
		-- cybran
		if faction == 'Cybran' then
			EffectUtil.SpawnBuildBots( self, unitBeingBuilt, self.BuildEffectsBag )
			EffectUtil.CreateCybranBuildBeams( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )
		elseif faction == 'Aeon' then
			EffectUtil.CreateAeonCommanderBuildingEffects( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )
		elseif faction == 'UEF' then
			--If we are assisting an upgrading unit, or repairing a unit, play separate effects
			if (order == 'Repair' and not unitBeingBuilt:IsBeingBuilt()) or (UpgradesFrom and UpgradesFrom ~= 'none' and self:IsUnitState('Guarding'))then
				EffectUtil.CreateDefaultBuildBeams( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )
			else
				EffectUtil.CreateUEFCommanderBuildSliceBeams( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )        
			end
		else
			EffectUtil.CreateSeraphimUnitEngineerBuildingEffects( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )
		end
    end,
	
	-- cybran build effect
        --EffectUtil.SpawnBuildBots( self, unitBeingBuilt, self.BuildEffectsBag )
        --EffectUtil.CreateCybranBuildBeams( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )
	-- aeon build effect 
		-- EffectUtil.CreateAeonCommanderBuildingEffects( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )

    CreateEnhancement = function(self, enh)
        oldXSL0001.CreateEnhancement(self, enh)
		
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
            self:AddBuildRestriction(categories.CYBRAN)
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
		elseif enh =='AeonEngineering' then
            local cat = ParseEntityCategory(bp.BuildableCategoryAdds)
            self:RemoveBuildRestriction(cat)
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
        elseif enh =='AeonEngineeringRemove' then
            local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
			self:AddBuildRestriction(categories.AEON)
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
		elseif enh =='UEFEngineering' then
            local cat = ParseEntityCategory(bp.BuildableCategoryAdds)
            self:RemoveBuildRestriction(cat)
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
        elseif enh =='UEFEngineeringRemove' then
            local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
			self:AddBuildRestriction(categories.UEF)
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
			-- ***
			--
        elseif enh =='AdvancedEngineeringRemove' then
            local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
            self:RestoreBuildRestrictions()
            self:AddBuildRestriction( categories.SERAPHIM * (categories.BUILTBYTIER2COMMANDER + categories.BUILTBYTIER3COMMANDER) )
            if Buff.HasBuff( self, 'SeraphimACUT2BuildRate' ) then
                Buff.RemoveBuff( self, 'SeraphimACUT2BuildRate' )
			end
			
			self:AddBuildRestriction(categories.CYBRAN)
			self:AddBuildRestriction(categories.AEON)
			self:AddBuildRestriction(categories.UEF)
			--
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
        elseif enh =='T3EngineeringRemove' then
            local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
            self:RestoreBuildRestrictions()
            if Buff.HasBuff( self, 'SeraphimACUT3BuildRate' ) then
                Buff.RemoveBuff( self, 'SeraphimACUT3BuildRate' )
            end
            self:AddBuildRestriction( categories.SERAPHIM * ( categories.BUILTBYTIER2COMMANDER + categories.BUILTBYTIER3COMMANDER) )
        	--
			self:AddBuildRestriction(categories.CYBRAN)
			self:AddBuildRestriction(categories.AEON)
			self:AddBuildRestriction(categories.UEF)
			--
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
		end
		
    end,
}

TypeClass = XSL0001
