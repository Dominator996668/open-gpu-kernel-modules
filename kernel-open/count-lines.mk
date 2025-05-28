# Include the top-level makefile to get $(NV_KERNEL_MODULES)
include Makefile

# Set $(src) for the to-be-included nvidia*.Kbuild files
src := $(CURDIR)

# Concatenate all of the conftest lists
ALL_CONFTESTS := $(sort $(NV_CONFTEST_FUNCTION_COMPILE_TESTS) \
                        $(NV_CONFTEST_GENERIC_COMPILE_TESTS)  \
                        $(NV_CONFTEST_MACRO_COMPILE_TESTS)    \
                        $(NV_CONFTEST_SYMBOL_COMPILE_TESTS)   \
                        $(NV_CONFTEST_TYPE_COMPILE_TESTS)     \
                  )

# Collect objects from modules
ALL_OBJECTS :=
$(foreach _module, $(NV_KERNEL_MODULES), \
    $(eval include $(_module)/$(_module).Kbuild) \
    $(eval ALL_OBJECTS += $($(notdir $(_module))-y)) \
)

# Immediately expand ALL_OBJECTS to avoid deferred evaluation issues
ALL_OBJECTS := $(ALL_OBJECTS)

count:
    @echo "conftests:$(words $(ALL_CONFTESTS))" \
          "objects:$(words $(NV_OBJECTS_DEPEND_ON_CONFTEST))" \
          "modules:$(words $(NV_KERNEL_MODULES))"

.PHONY: count
